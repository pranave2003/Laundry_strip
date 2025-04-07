//part of 'driverbloc_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'Drivermodel/Drivermodel.dart';

@immutable
sealed class DriverblocEvent {}

class drivercheckloginstateevent extends DriverblocEvent {}

// login

class DriverLoginEvent extends DriverblocEvent {
  final String Email;
  final String Password;

  DriverLoginEvent({required this.Email, required this.Password});
}

// Signup
class DriverSignupEvent extends DriverblocEvent {
  final Driver driver;
  DriverSignupEvent({required this.driver});
}

class FetchDriverDetailsById extends DriverblocEvent {}

class AddDriverEvent extends DriverblocEvent {
  final Driver driver;

  AddDriverEvent(this.driver);
}

//edit profile
class EditDriverProfile extends DriverblocEvent {
  final Driver driver;
  EditDriverProfile({required this.driver});
}

// update Profile

class PickUploadImageEvent extends DriverblocEvent {}

//signout

class DriverSigOutEvent extends DriverblocEvent {}

class FetchDrivers extends DriverblocEvent {
  final bool status;
  final String? searchQuery;
  FetchDrivers({required this.status, required this.searchQuery});
}

class DeleteDriver extends DriverblocEvent {
  final String id;
  DeleteDriver({required this.id});
}
