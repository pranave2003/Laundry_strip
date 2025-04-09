//part of 'driverbloc_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'Drivermodel/Drivermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

@immutable
sealed class DriverblocState {}

final class DriverblocInitial extends DriverblocState {}

class DriverAuthloading extends DriverblocState {}

class DriverAuthenticated extends DriverblocState {
  User? user;
  DriverAuthenticated(this.user);
}

class DriverUnAuthenticated extends DriverblocState {}

class DriverAuthenticatedError extends DriverblocState {
  final String message;

  DriverAuthenticatedError({required this.message});
}

//fetch by id

final class DriverByidLoaded extends DriverblocState {
  final Driver userData;
  DriverByidLoaded(this.userData);
}

class Driverloading extends DriverblocState {}

class DriverError extends DriverblocState {
  String error;
  DriverError({required this.error});
}

// profile

class ProfileImageInitial extends DriverblocState {}

class ProfileImageLoading extends DriverblocState {}

class ProfileImageSuccess extends DriverblocState {}

class ProfileImageFailure extends DriverblocState {
  final String error;
  ProfileImageFailure(this.error);

  @override
  List<Object?> get props => [error];
}

final class Refresh extends DriverblocState {}


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

class Driverload extends DriverblocState {
  final Driver driver;

  Driverload(
      this.driver,
      );
}