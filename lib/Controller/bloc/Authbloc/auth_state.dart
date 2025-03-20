part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class Authloading extends AuthState {}

class Authenticated extends AuthState {
  User? user;
  Authenticated(this.user);
}

class UnAuthenticated extends AuthState {}

class AuthenticatedError extends AuthState {
  final String message;

  AuthenticatedError({required this.message});
}

//
final class UserByidLoaded extends AuthState {
  final UserModel Userdata;
  UserByidLoaded(this.Userdata);
}

class Userloading extends AuthState {}

class UserError extends AuthState {
  String error;
  UserError({required this.error});
}
