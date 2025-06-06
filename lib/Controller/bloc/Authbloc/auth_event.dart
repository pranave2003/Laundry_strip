part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

// check auth or not
class checkloginstateevent extends AuthEvent {}

// login

class LoginEvent extends AuthEvent {
  final String Email;
  final String Password;

  LoginEvent({required this.Email, required this.Password});
}

// Signup
class SignupEvent extends AuthEvent {
  final UserModel user;
  SignupEvent({required this.user});
}

//signout

class SigOutEvent extends AuthEvent {}

// get user details
class FetchUserDetailsById extends AuthEvent {}

class FetchUsers extends AuthEvent {
  final String? searchQuery;
  FetchUsers({required this.searchQuery});

}

class EditProfile extends AuthEvent {
  final UserModel user;
  EditProfile({required this.user});
}
class PickAndUploadImageEvent extends AuthEvent {}

// class EditAddress extends AuthEvent {
//   final UserModel user;
//   EditAddress({required this.user});
// }

