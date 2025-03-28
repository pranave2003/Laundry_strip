part of 'addproduct_bloc.dart';

@immutable
sealed class AddproductEvent {}

final class Addproductevent extends AddproductEvent {
  final Addproductmodel model;
  Addproductevent({required this.model});
}
class FetchProduct extends AddproductEvent {
  final String? searchQuery;
  FetchProduct({required this.searchQuery});
}
class DeleteProduct extends AddproductEvent {
  final String? productid;
  DeleteProduct({required this.productid});
}
