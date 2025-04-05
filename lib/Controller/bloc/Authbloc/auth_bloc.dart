import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'dart:io' if (dart.library.html) 'dart:html' as html;
import 'dart:typed_data';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'Userauthmodel/Usermodel.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

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

    //Login
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
    User? user = _auth.currentUser;
    //Sign Out
    on<SigOutEvent>(
      (event, emit) async {
        try {
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

    // on<EditAddress>((event, emit) async {
    //   emit(UsersLoading());
    //   try {
    //     FirebaseFirestore.instance
    //         .collection("Laundry_Users")
    //         .doc(event.user.uid)
    //         .update({
    //       "place": event.user.place,
    //       "post": event.user.post,
    //       "pin": event.user.pin,
    //       "state": event.user.state,
    //       "District": event.user.District,
    //     });
    //     emit(Authenticated());
    //   } catch (e) {
    //     emit(Usersfailerror(e.toString()));
    //   }
    // });

    on<EditProfile>((event, emit) async {
      emit(UsersLoading());
      try {
        FirebaseFirestore.instance
            .collection("Laundry_Users")
            .doc(event.user.uid)
            .update({
          "name": event.user.name,
          "phone": event.user.phone,
          "imageUrl": event.user.imageUrl,
        });
        emit(Userload(event.user));
      } catch (e) {
        emit(Usersfailerror(e.toString()));
      }
    });

    //   update profilephoto

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
    //         "Userprofile/${DateTime.now().millisecondsSinceEpoch}.jpg";
    //
    //     // Upload to Firebase Storage
    //     UploadTask uploadTask =
    //         _firebaseStorage.ref(fileName).putFile(imageFile);
    //     TaskSnapshot snapshot = await uploadTask;
    //
    //     // Get Download URL
    //     String downloadUrl = await snapshot.ref.getDownloadURL();
    //     print(downloadUrl);
    //     if (user != null) {
    //       FirebaseFirestore.instance
    //           .collection("Laundry_Users")
    //           .doc(user.uid)
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

          emit(ProfileImageFailure("No image selected."));

          return; // User canceled selection
        }

        String fileName =
            "Userprofile/${DateTime.now().millisecondsSinceEpoch}.jpg";
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
        if (user != null) {
          await FirebaseFirestore.instance
              .collection("Laundry_Users")
              .doc(user.uid)
              .update({"imageUrl": downloadUrl});
        }

        emit(ProfileImageSuccess());
      } catch (e) {
        print("Error: $e");
        emit(ProfileImageFailure("Failed to upload image"));
      }
    });
  }
}
