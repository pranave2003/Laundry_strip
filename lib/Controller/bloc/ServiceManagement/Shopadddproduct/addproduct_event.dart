part of 'addproduct_bloc.dart';

@immutable
sealed class AddproductEvent {}

final class Addproductevent extends AddproductEvent {
  final Addproductmodel model;
  Addproductevent({required this.model});
}
