import 'package:flutter/cupertino.dart';

import 'Drivermodel/Drivermodel.dart';

@immutable
sealed class DriverblocState {}

final class DriverblocInitial extends DriverblocState {}

final class DriverLoading extends DriverblocState {}

final class DriverSuccess extends DriverblocState {}

final class DriverFailure extends DriverblocState {
  final String error;

  DriverFailure(this.error);
}

class Driverloaded extends DriverblocState {
  final List<Driver> Drivers;

  Driverloaded(
    this.Drivers,
  );
}
