import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'Drivermodel/Drivermodel.dart';
import 'driverbloc_event.dart';
import 'driverbloc_state.dart';

final Driverid_blobal = FirebaseAuth.instance.currentUser!.uid;

class DriverblocBloc extends Bloc<DriverblocEvent, DriverblocState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  DriverblocBloc() : super(DriverblocInitial()) {
    on<drivercheckloginstateevent>(
      (event, emit) async {
        User? user;
        try {
          await Future.delayed(Duration(seconds: 3));
          user = _auth.currentUser;
          if (user != null) {
            emit(DriverAuthenticated(user));
          } else {
            emit(DriverUnAuthenticated());
          }
        } catch (e) {
          emit(DriverAuthenticatedError(
            message:
                e.toString().split('] ').last, // Extracts only the message part
          ));
        }
      },
    );
    // Signup
    on<DriverSignupEvent>(
      (event, emit) async {
        emit(DriverAuthloading());
        try {
          final usercredential = await _auth.createUserWithEmailAndPassword(
              email: event.driver.email.toString(),
              password: event.driver.password.toString());

          final user = usercredential.user;

          if (user != null) {
            FirebaseFirestore.instance.collection("drivers").doc(user.uid).set({
              "driverId": user.uid,
              "email": user.email,
              "name": event.driver.name,
              "timestamp": DateTime.now(),
              "ban": "0",
              "status": "1",
              "phone": event.driver.phone,
              "proof": event.driver.proof,
              "imageUrl":
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4ZqivCNC7yvJqthqZOVvxSjDLyDxtai-cbQ&s",
            });
            emit(DriverAuthenticated(user));

            print(user);
          } else {
            emit(DriverUnAuthenticated());
          }
        } catch (e) {
          emit(DriverAuthenticatedError(message: e.toString().split("]").last));
          print("Authenticated Error : ${e.toString().split(']').last}");
        }
      },
    );

    //Login
    on<DriverLoginEvent>(
      (event, emit) async {
        emit(DriverAuthloading());
        try {
          final userCredential = await _auth.signInWithEmailAndPassword(
              email: event.Email, password: event.Password);
          final user = userCredential.user;

          if (user != null) {
            print("Id=======${user.uid}");

            // Fetch user document from Firestore
            DocumentSnapshot userDoc = await FirebaseFirestore.instance
                .collection("drivers")
                .doc(user.uid)
                .get();

            if (userDoc.exists) {
              final userData = userDoc.data() as Map<String, dynamic>;

              // Check if the 'Ban' field is 1
              if (userData['ban'] == "1") {
                // Update OneSignal ID
                await FirebaseFirestore.instance
                    .collection("drivers")
                    .doc(user.uid)
                    .update({"Onesignal_id": "playerId"});

                emit(DriverAuthenticated(user));
                print("Auth successfully");
              } else {
                // Ban field is 0, return account deleted message
                await _auth.signOut();
                emit(DriverAuthenticatedError(
                    message: "Your account has been deleted."));
                print("Your account has been deleted.");
              }
            } else {
              // User document does not exist
              await _auth.signOut();
              emit(DriverAuthenticatedError(message: "Driver data not found."));
              print("Driver data not found.");
            }
          } else {
            emit(DriverUnAuthenticated());
            print("Auth failed");
          }
        } catch (e) {
          emit(DriverAuthenticatedError(message: e.toString()));
          print("login : ${e.toString()}");
        }
      },
    );

    on<FetchDriver>((event, emit) async {
      emit(DriverLoading());
      try {
        CollectionReference driverCollection =
            FirebaseFirestore.instance.collection('drivers');

        Query query = driverCollection;
        query = query.where("status", isEqualTo: event.status);
        QuerySnapshot snapshot = await query.get();

        List<Driver> driver = snapshot.docs.map((doc) {
          return Driver.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
          driver = driver.where((viewdriver) {
            return viewdriver.name!
                .toLowerCase()
                .contains(event.searchQuery!.toLowerCase());
          }).toList();
        }

        emit(Driverloaded(driver));
      } catch (e) {
        emit(DriverFailure(e.toString()));
      }
    });

//fetch by id
    User? driver = _auth.currentUser;
    on<FetchDriverDetailsById>((event, emit) async {
      emit(Driverloading());
      final driver = FirebaseAuth.instance.currentUser;
      print("Driver loading ${driver?.uid}");

      if (driver != null) {
        try {
          final doc = await FirebaseFirestore.instance
              .collection('drivers')
              .doc(driver.uid)
              .get();

          print("Document fetched");

          if (doc.exists && doc.data() != null) {
            Driver userData = Driver.fromMap(doc.data()!);
            print("userData: $userData");
            emit(DriverByidLoaded(userData));
          } else {
            emit(DriverError(error: "Driver profile not found"));
          }
        } catch (e) {
          print(e);
          emit(DriverError(error: e.toString()));
        }
      } else {
        print("error");
        emit(DriverError(error: "Driver not authenticated"));
      }
    });

    on<PickUploadImageEvent>((event, emit) async {
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
            "driver_profile/${DateTime.now().millisecondsSinceEpoch}.jpg";
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
        if (driver != null) {
          await FirebaseFirestore.instance
              .collection("drivers")
              .doc(driver.uid)
              .update({"imageUrl": downloadUrl});
        }

        emit(ProfileImageSuccess());
      } catch (e) {
        print("Error: $e");
        emit(ProfileImageFailure("Failed to upload image"));
      }
    });

    on<EditDriverProfile>((event, emit) async {
      emit(DriverLoading());
      try {
        FirebaseFirestore.instance
            .collection("drivers")
            .doc(event.driver.driverId)
            .update({
          "name": event.driver.name,
          "phone": event.driver.phone,
          "image": event.driver.image,
        });
        emit(Driverload(event.driver));
      } catch (e) {
        emit(DriverFailure(e.toString()));
      }
    });

    on<DriverSigOutEvent>(
      (event, emit) async {
        try {
          User? user = _auth.currentUser;

          if (user != null) {
            // Get the Player ID from OneSignalService

            // Update Firestore with the correct user ID and OneSignal ID
            await FirebaseFirestore.instance
                .collection("drivers")
                .doc(user.uid) // Use current user's UID
                .update({"Onesignal_id": "null"}); // Update with OneSignal ID

            // Sign out the user
            await _auth.signOut();
            emit(DriverUnAuthenticated());
          } else {
            emit(DriverAuthenticatedError(message: "No user is logged in"));
          }
        } catch (e) {
          emit(DriverAuthenticatedError(message: e.toString()));
        }
      },
    );

    //accept reject

    on<AcceptReject>(
      (event, emit) async {
        print("Accept");
        try {
          // Get the Player ID from OneSignalService
          print(event.driverId);
          // Update Firestore with the correct user ID and OneSignal ID
          await FirebaseFirestore.instance
              .collection("drivers")
              .doc(event.driverId) // Use current user's UID
              .update({"status": event.status}); // Update with OneSignal ID

          // Sign out the user

          emit(Refresh());
        } catch (e) {
          emit(DriverFailure(e.toString()));
        }
      },
    );

//Ban Driver
    on<BanDriver>(
      (event, emit) async {
        print("Accept");
        try {
          // Get the Player ID from OneSignalService
          print(event.driverId);
          // Update Firestore with the correct user ID and OneSignal ID
          await FirebaseFirestore.instance
              .collection("drivers")
              .doc(event.driverId) // Use current user's UID
              .update({"ban": event.ban}); // Update with OneSignal ID

          // Sign out the user

          emit(Refresh());
        } catch (e) {
          emit(DriverFailure(e.toString()));
        }
      },
    );

    // old commented

    on<AddDriverEvent>(_onAddDriver);
    on<FetchDrivers>(_fetchDrivers);
    on<DeleteDriver>(_deleteDrivers);
  }

  Future<void> _deleteDrivers(
      DeleteDriver event, Emitter<DriverblocState> emit) async {
    emit(DriverLoading());
    try {
      await firestore.collection("drivers").doc(event.id).delete();
      add(FetchDrivers(status: true, searchQuery: null));
    } catch (e) {
      emit(DriverFailure(e.toString()));
    }
  }

  Future<void> _onAddDriver(
      AddDriverEvent event, Emitter<DriverblocState> emit) async {
    emit(DriverLoading());
    try {
      DocumentReference docRef = firestore.collection('drivers').doc();

      await docRef.set({
        'driverId': docRef.id,
        'name': event.driver.name,
        'phone': event.driver.phone,
        'email': event.driver.email,
        'image': event.driver.image,
        'available': event.driver.available,
        'timestamp': event.driver.timestamp,
      });

      print("Driver added successfully");

      // Fetch updated drivers before emitting success
      await _fetchDrivers(
          FetchDrivers(status: true, searchQuery: "null"), emit);

      emit(DriverSuccess());
    } catch (e) {
      emit(DriverFailure(e.toString()));
    }
  }

  Future<void> _fetchDrivers(
      FetchDrivers event, Emitter<DriverblocState> emit) async {
    emit(DriverLoading());
    try {
      CollectionReference driversCollection =
          FirebaseFirestore.instance.collection('drivers');

      Query query = driversCollection; // You can add filters here if needed

      query = query.where("isActive", isEqualTo: event.status);

      QuerySnapshot snapshot = await query.get();

      List<Driver> drivers = snapshot.docs.map((doc) {
        return Driver(
          driverId: doc['driverId'],
          email: doc['email'],
          password: doc['password'],
          proof: doc['proof'],
          available: doc['available'],
          phone: doc['phone'],
          name: doc['name'],
          image: doc['image'] ?? "",
          timestamp: doc["timestamp"] ?? "",
        );
      }).toList();
      if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
        drivers = drivers.where((driver) {
          return driver.name
              .toLowerCase()
              .contains(event.searchQuery!.toLowerCase());
        }).toList();
      }
      emit(Driverloaded(drivers));
    } catch (e) {
      emit(DriverFailure(e.toString()));
    }
  }
}
