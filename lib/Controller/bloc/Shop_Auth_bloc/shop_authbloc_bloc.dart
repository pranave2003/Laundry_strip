import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import 'Shopmodel/Shopmodel.dart';

part 'shop_authbloc_event.dart';
part 'shop_authbloc_state.dart';

class ShopAuthblocBloc extends Bloc<ShopAuthblocEvent, ShopAuthblocState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ShopAuthblocBloc() : super(ShopAuthblocInitial()) {
    on<shopcheckloginstateevent>(
          (event, emit) async {
        User? user;
        try {
          await Future.delayed(Duration(seconds: 3));
          user = _auth.currentUser;
          if (user != null) {
            emit(ShopAuthenticated(user));
          } else {
            emit(ShopUnAuthenticated());
          }
        } catch (e) {
          emit(ShopAuthenticatedError(
            message:
            e.toString().split('] ').last, // Extracts only the message part
          ));
        }
      },
    );

    on<ShopSignupEvent>((event, emit) async{
      emit(ShopAuthloading());
      try {
        final usercredential = await _auth.createUserWithEmailAndPassword(
            email: event.shop.email.toString(),
            password: event.shop.password.toString());

        final user = usercredential.user;

        if (user != null) {
          FirebaseFirestore.instance
              .collection("Laundry_Shops")
              .doc(user.uid)
              .set({
            "shopId": user.uid,
            "email": user.email,
            "owner_name": event.shop.owner_name,
            "Shop_Name":event.shop.shop_name,
            "timestamp": DateTime.now(),
            "ban": "1",
            "status": "1",
            "phone": event.shop.phone,
            "street": event.shop.street,
            "city": event.shop.city,
            "post": event.shop.post,
            //"Address": event.shop.shopAddress,
            "District": event.shop.District,
            "Laundry_Capacity": event.shop.LaundryCapacity,
            "imageUrl":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4ZqivCNC7yvJqthqZOVvxSjDLyDxtai-cbQ&s",
          });
          emit(ShopAuthenticated(user));

          print(user);
        } else {
          emit(ShopUnAuthenticated());
        }
      } catch (e) {
        emit(ShopAuthenticatedError(message: e.toString().split("]").last));
        print("Authenticated Error : ${e.toString().split(']').last}");
      }

    });

    on<ShopLoginEvent>(
          (event, emit) async {
        emit(ShopAuthloading());
        try {
          final userCredential = await _auth.signInWithEmailAndPassword(
              email: event.Email, password: event.Password);
          final user = userCredential.user;

          if (user != null) {
            print("Id=======${user.uid}");

            // Fetch user document from Firestore
            DocumentSnapshot userDoc = await FirebaseFirestore.instance
                .collection("Laundry_Shops")
                .doc(user.uid)
                .get();

            if (userDoc.exists) {
              final userData = userDoc.data() as Map<String, dynamic>;

              // Check if the 'Ban' field is 1
              if (userData['ban'] == "1") {
                // Update OneSignal ID
                await FirebaseFirestore.instance
                    .collection("Laundry_Shops")
                    .doc(user.uid)
                    .update({"Onesignal_id": "playerId"});

                emit(ShopAuthenticated(user));
                print("Auth successfully");
              } else {
                // Ban field is 0, return account deleted message
                await _auth.signOut();
                emit(ShopAuthenticatedError(
                    message: "Your account has been deleted."));
                print("Your account has been deleted.");
              }
            } else {
              // User document does not exist
              await _auth.signOut();
              emit(ShopAuthenticatedError(message: "User data not found."));
              print("User data not found.");
            }
          } else {
            emit(ShopUnAuthenticated());
            print("Auth failed");
          }
        } catch (e) {
          emit(ShopAuthenticatedError(message: e.toString()));
          print("login : ${e.toString()}");
        }
      },
    );

    on<FetchShopDetailsById>((event, emit) async {
      emit(Shoploading());
      User? shop = _auth.currentUser;

      if (shop != null) {
        try {
          final shop = FirebaseAuth.instance.currentUser;
          if (shop != null) {
            final doc = await FirebaseFirestore.instance
                .collection('Laundry_Shops')
                .doc(shop.uid)
                .get();

            if (doc.exists) {
              ShopModel userData = ShopModel.fromMap(doc.data()!);
              emit(ShopByidLoaded(userData));
            } else {
              emit(ShopError(error: "Shop profile not found"));
            }
          } else {
            emit(ShopError(error: "Shop not authenticated"));
          }
        } catch (e) {
          emit(ShopError(error: e.toString()));
        }
      }
    });
    on<ShopSigOutEvent>(
          (event, emit) async {
        try {
          User? user = _auth.currentUser;

          if (user != null) {
            // Get the Player ID from OneSignalService

            // Update Firestore with the correct user ID and OneSignal ID
            await FirebaseFirestore.instance
                .collection("Laundry_Shops")
                .doc(user.uid) // Use current user's UID
                .update({"Onesignal_id": "null"}); // Update with OneSignal ID

            // Sign out the user
            await _auth.signOut();
            emit(ShopUnAuthenticated());
          } else {
            emit(ShopAuthenticatedError(message: "No user is logged in"));
          }
        } catch (e) {
          emit(ShopAuthenticatedError(message: e.toString()));
        }
      },
    );


    on<FetchShop>((event, emit) async {
      emit(ShopLoading());
      try {
        CollectionReference shopCollection =
        FirebaseFirestore.instance.collection('Laundry_Shops');

        Query query = shopCollection;
        QuerySnapshot snapshot = await query.get();

        List<ShopModel> shop = snapshot.docs.map((doc) {
          return ShopModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
          shop = shop.where((viewshop) {
            return viewshop.owner_name!
                .toLowerCase()
                .contains(event.searchQuery!.toLowerCase());
          }).toList();
        }

        emit(Shoploaded(shop));
      } catch (e) {
        emit(Shopfailerror(e.toString()));
      }
    });

  }
}

