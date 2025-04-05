import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import 'Shopmodel/Shopmodel.dart';

part 'shop_authbloc_event.dart';
part 'shop_authbloc_state.dart';

class ShopAuthblocBloc extends Bloc<ShopAuthblocEvent, ShopAuthblocState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();

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

    on<ShopSignupEvent>((event, emit) async {
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
            "Shop_Name": event.shop.shop_name,
            "timestamp": DateTime.now(),
            "ban": "0",
            "status": "0",
            "phone": event.shop.phone,
            "street": event.shop.street,
            "city": event.shop.city,
            "post": event.shop.post,
            //"Address": event.shop.shopAddress,
            "District": event.shop.District,
            "Laundry_Capacity": event.shop.LaundryCapacity,
            "Services": event.shop.selectServices,
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

    User? shop = _auth.currentUser;
    on<FetchShopDetailsById>((event, emit) async {
      emit(Shoploading());

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

    on<AcceptReject>(
      (event, emit) async {
        print("Acccpet");
        try {
          // Get the Player ID from OneSignalService
          print(event.shopid);
          // Update Firestore with the correct user ID and OneSignal ID
          await FirebaseFirestore.instance
              .collection("Laundry_Shops")
              .doc(event.shopid) // Use current user's UID
              .update({"status": event.status}); // Update with OneSignal ID

          // Sign out the user

          emit(Refresh());
        } catch (e) {
          emit(Shopfailerror(e.toString()));
        }
      },
    );

    on<EditShopProfile>((event, emit) async {
      emit(ShopLoading());
      try {
        FirebaseFirestore.instance
            .collection("Laundry_Shops")
            .doc(event.shop.shopid)
            .update({
          "Shop_Name": event.shop.shop_name,
          "phone": event.shop.phone,
          "ShopImage": event.shop.ShopImage,
        });
        emit(Shopload(event.shop));
      } catch (e) {
        emit(Shopfailerror(e.toString()));
      }
    });
    // update Profile
    // on<PickAndUploadImageEvent>((event, emit) async {
    //   try {
    //     // Pick Image from Gallery
    //     final pickedFile =
    //         await _imagePicker.pickImage(source: ImageSource.gallery);
    //     if (pickedFile == null) {
    //       return; // User canceled image selection
    //     }
    //
    //     emit(ProfileImageLoading());
    //
    //     File imageFile = File(pickedFile.path);
    //     String fileName =
    //         "Shop_profile/${DateTime.now().millisecondsSinceEpoch}.jpg";
    //
    //     // Upload to Firebase Storage
    //     UploadTask uploadTask =
    //         _firebaseStorage.ref(fileName).putFile(imageFile);
    //     TaskSnapshot snapshot = await uploadTask;
    //
    //     // Get Download URL
    //     String downloadUrl = await snapshot.ref.getDownloadURL();
    //     print(downloadUrl);
    //     if (shop != null) {
    //       FirebaseFirestore.instance
    //           .collection("Laundry_Shops")
    //           .doc(shop.uid)
    //           .update({"imageUrl": downloadUrl});
    //     }
    //     emit(ProfileImageSuccess());
    //   } catch (e) {
    //     print(e);
    //     emit(ProfileImageFailure("Failed to upload image"));
    //   }
    // });

    on<PickAndUploadImageEvent>((event, emit) async {
      try {
        emit(ProfileImageLoading());

        // ✅ Open file picker
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image, // Pick only image files
          withData: true, // Required for web
        );

        if (result == null) {
          print("No image selected.");
          return; // User canceled selection
        }

        String fileName =
            "Shop_profile/${DateTime.now().millisecondsSinceEpoch}.jpg";
        Reference storageRef = _firebaseStorage.ref().child(fileName);
        UploadTask uploadTask;

        if (kIsWeb) {
          // ✅ Web: Upload image as bytes
          Uint8List imageData = result.files.first.bytes!;
          uploadTask = storageRef.putData(imageData);
        } else {
          // ✅ Mobile: Upload image as a File
          File imageFile = File(result.files.first.path!);
          uploadTask = storageRef.putFile(imageFile);
        }

        // ✅ Wait for the upload to complete
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        print("Uploaded Image URL: $downloadUrl");

        // ✅ Update Firestore with the image URL
        if (shop != null) {
          await FirebaseFirestore.instance
              .collection("Laundry_Shops")
              .doc(shop.uid)
              .update({"imageUrl": downloadUrl});
        }

        emit(ProfileImageSuccess());
      } catch (e) {
        print("Error: $e");
        emit(ProfileImageFailure("Failed to upload image"));
      }
    });
    on<FetchShop>((event, emit) async {
      emit(ShopLoading());
      try {
        CollectionReference shopCollection =
            FirebaseFirestore.instance.collection('Laundry_Shops');

        Query query = shopCollection;
        query = query.where("status", isEqualTo: event.status);
        QuerySnapshot snapshot = await query.get();

        List<ShopModel> shop = snapshot.docs.map((doc) {
          return ShopModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
          shop = shop.where((viewshop) {
            return viewshop.shop_name!
                .toLowerCase()
                .contains(event.searchQuery!.toLowerCase());
          }).toList();
        }

        emit(Shoploaded(shop));
      } catch (e) {
        emit(Shopfailerror(e.toString()));
      }
    });

    on<UserFetchShop>((event, emit) async {
      emit(ShopLoading());
      try {
        CollectionReference shopCollection =
            FirebaseFirestore.instance.collection('Laundry_Shops');

        Query query = shopCollection;
        query = query.where("Services", arrayContains: event.service);
        query = query.where("status", isEqualTo: event.status);

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
