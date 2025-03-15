import 'package:flutter/cupertino.dart';

import 'Drivermodel/Drivermodel.dart';

@immutable
sealed class DriverblocEvent {}

class AddDriverEvent extends DriverblocEvent {
  final Driver driver;

  AddDriverEvent(this.driver);
}

class FetchDrivers extends DriverblocEvent {
  final bool status;
  final String? searchQuery;
  FetchDrivers({required this.status, required this.searchQuery});
}

class DeleteDriver extends DriverblocEvent {
  final String id;
  DeleteDriver({required this.id});
}
