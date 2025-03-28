part of 'addproduct_bloc.dart';

@immutable
sealed class AddproductState {}

final class AddproductInitial extends AddproductState {}

final class AddproductLoading extends AddproductState {}

final class Addproductsuccess extends AddproductState {}

final class ProductDelete extends AddproductState {}

final class AddproductLoaded extends AddproductState {
  final List<Addproductmodel> product;

  AddproductLoaded(this.product);
}

final class addproductfail extends AddproductState {
  final String error;
  addproductfail({required this.error});
}
