import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Drivermodel/Drivermodel.dart';
import 'driverbloc_event.dart';
import 'driverbloc_state.dart';

class DriverblocBloc extends Bloc<DriverblocEvent, DriverblocState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  DriverblocBloc() : super(DriverblocInitial()) {
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
        'isActive': event.driver.isActive,
        'timestamp': event.driver.timestamp,
      });

      print("Driver added successfully");

      // Fetch updated drivers before emitting success
      await _fetchDrivers(
          FetchDrivers(status: true, searchQuery: "null"), emit);

      // emit(DriverSuccess());
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
          isActive: doc['isActive'],
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
