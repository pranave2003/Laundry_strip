part of 'addproduct_bloc.dart';

@immutable
sealed class AddproductEvent {}

final class Addproductevent extends AddproductEvent {
  final Addproductmodel model;
  Addproductevent({required this.model});
}

class FetchProduct extends AddproductEvent {
  final String? searchQuery;
  final String? shopid;
  FetchProduct({required this.searchQuery, this.shopid});
}

class FetchproductinUser extends AddproductEvent {
  final String? searchQuery;
  final String? shopid;
  FetchproductinUser({required this.searchQuery, required this.shopid});
}

class DeleteProduct extends AddproductEvent {
  final String? productid;
  DeleteProduct({required this.productid});
}
