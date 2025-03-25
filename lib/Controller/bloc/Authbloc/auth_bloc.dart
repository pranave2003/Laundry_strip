import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import 'Userauthmodel/Usermodel.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthBloc() : super(AuthInitial()) {
    // check Auth or Not
    on<checkloginstateevent>(
      (event, emit) async {
        User? user;
        try {
          await Future.delayed(Duration(seconds: 3));
          user = _auth.currentUser;
          if (user != null) {
            emit(Authenticated(user));
          } else {
            emit(UnAuthenticated());
          }
        } catch (e) {
          emit(AuthenticatedError(
            message:
                e.toString().split('] ').last, // Extracts only the message part
          ));
        }
      },
    );
    // Signup
    on<SignupEvent>(
      (event, emit) async {
        emit(Authloading());
        try {
          final usercredential = await _auth.createUserWithEmailAndPassword(
              email: event.user.email.toString(),
              password: event.user.password.toString());

          final user = usercredential.user;

          if (user != null) {
            FirebaseFirestore.instance
                .collection("Laundry_Users")
                .doc(user.uid)
                .set({
              "userId": user.uid,
              "email": user.email,
              "name": event.user.name,
              "timestamp": DateTime.now(),
              "ban": "1",
              "status": "1",
              "phone": event.user.phone,
              "place": event.user.place,
              "post": event.user.post,
              "pin": event.user.pin,
              "state": event.user.state,
              "District": event.user.District,
              "imageUrl":
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4ZqivCNC7yvJqthqZOVvxSjDLyDxtai-cbQ&s",
            });
            emit(Authenticated(user));

            print(user);
          } else {
            emit(UnAuthenticated());
          }
        } catch (e) {
          emit(AuthenticatedError(message: e.toString().split("]").last));
          print("Authenticated Error : ${e.toString().split(']').last}");
        }
      },
    );
    on<LoginEvent>(
          (event, emit) async {
        emit(Authloading());
        try {
          final userCredential = await _auth.signInWithEmailAndPassword(
              email: event.Email, password: event.Password);
          final user = userCredential.user;

          if (user != null) {
            print("Id=======${user.uid}");

            // Fetch user document from Firestore
            DocumentSnapshot userDoc = await FirebaseFirestore.instance
                .collection("Laundry_Users")
                .doc(user.uid)
                .get();

            if (userDoc.exists) {
              final userData = userDoc.data() as Map<String, dynamic>;

              // Check if the 'Ban' field is 1
              if (userData['ban'] == "1") {
                // Update OneSignal ID
                await FirebaseFirestore.instance
                    .collection("Laundry_Users")
                    .doc(user.uid)
                    .update({"Onesignal_id": "playerId"});

                emit(Authenticated(user));
                print("Auth successfully");
              } else {
                // Ban field is 0, return account deleted message
                await _auth.signOut();
                emit(AuthenticatedError(
                    message: "Your account has been deleted."));
                print("Your account has been deleted.");
              }
            } else {
              // User document does not exist
              await _auth.signOut();
              emit(AuthenticatedError(message: "User data not found."));
              print("User data not found.");
            }
          } else {
            emit(UnAuthenticated());
            print("Auth failed");
          }
        } catch (e) {
          emit(AuthenticatedError(message: e.toString()));
          print("login : ${e.toString()}");
        }
      },
    );

    // logout
    // on<SigOutEvent>(
    //   (event, emit) async {
    //     User? user=_auth.currentUser;
    //     try {
    //       user = _auth.currentUser;
    //
    //      await FirebaseFirestore.instance
    //           .collection("User")
    //           .doc(user.uid)
    //           .update({"Onesignal_id": 12121});
    //       await _auth.signOut();
    //       emit(UnAuthenticated());
    //     } catch (e) {
    //       emit(AuthenticatedError(message: e.toString()));
    //     }
    //   },
    // );

    on<FetchUserDetailsById>((event, emit) async {
      emit(Userloading());
      User? user = _auth.currentUser;

      if (user != null) {
        try {
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            final doc = await FirebaseFirestore.instance
                .collection('Laundry_Users')
                .doc(user.uid)
                .get();

            if (doc.exists) {
              UserModel userData = UserModel.fromMap(doc.data()!);
              emit(UserByidLoaded(userData));
            } else {
              emit(UserError(error: "User profile not found"));
            }
          } else {
            emit(UserError(error: "User not authenticated"));
          }
        } catch (e) {
          emit(UserError(error: e.toString()));
        }
      }
    });
    on<SigOutEvent>(
      (event, emit) async {
        try {
          User? user = _auth.currentUser;

          if (user != null) {
            // Get the Player ID from OneSignalService

            // Update Firestore with the correct user ID and OneSignal ID
            await FirebaseFirestore.instance
                .collection("Laundry_Users")
                .doc(user.uid) // Use current user's UID
                .update({"Onesignal_id": "null"}); // Update with OneSignal ID

            // Sign out the user
            await _auth.signOut();
            emit(UnAuthenticated());
          } else {
            emit(AuthenticatedError(message: "No user is logged in"));
          }
        } catch (e) {
          emit(AuthenticatedError(message: e.toString()));
        }
      },
    );


    on<FetchUsers>((event, emit) async {
      emit(UsersLoading());
      try {
        CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Laundry_Users');

        Query query = usersCollection;
        QuerySnapshot snapshot = await query.get();

        List<UserModel> users = snapshot.docs.map((doc) {
          return UserModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
          users = users.where((viewuser) {
            return viewuser.name!
                .toLowerCase()
                .contains(event.searchQuery!.toLowerCase());
          }).toList();
        }

        emit(Usersloaded(users));
      } catch (e) {
        emit(Usersfailerror(e.toString()));
      }
    });

  }
}
