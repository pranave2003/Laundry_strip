part of 'shop_authbloc_bloc.dart';

@immutable
sealed class ShopAuthblocState {}

final class ShopAuthblocInitial extends ShopAuthblocState {}

class ShopAuthloading extends ShopAuthblocState {}

class ShopAuthenticated extends ShopAuthblocState {
  User? user;
  ShopAuthenticated(this.user);
}

class ShopUnAuthenticated extends ShopAuthblocState {}

class ShopAuthenticatedError extends ShopAuthblocState {
  final String message;

  ShopAuthenticatedError({required this.message});
}

// profile

class ProfileImageInitial extends ShopAuthblocState {}

class ProfileImageLoading extends ShopAuthblocState {}

class ProfileImageSuccess extends ShopAuthblocState {
}

class ProfileImageFailure extends ShopAuthblocState {
  final String error;
  ProfileImageFailure(this.error);

  @override
  List<Object?> get props => [error];
}

//fetch by id
final class ShopByidLoaded extends ShopAuthblocState {
  final ShopModel userData;
  ShopByidLoaded(this.userData);
}

class Shoploading extends ShopAuthblocState {}

class ShopError extends ShopAuthblocState {
  String error;
  ShopError({required this.error});
}

////
final class ShopLoading extends ShopAuthblocState {}

final class ShopGetSuccess extends ShopAuthblocState {}

final class Shopfailerror extends ShopAuthblocState {
  final String error;

  Shopfailerror(this.error);
}

class Shoploaded extends ShopAuthblocState {
  final List<ShopModel> Shop;

  Shoploaded(
    this.Shop,
  );
}
