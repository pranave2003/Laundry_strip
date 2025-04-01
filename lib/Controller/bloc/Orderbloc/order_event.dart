part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class placeorder extends OrderEvent {
  final OrderModel order;
  placeorder(this.order);
}

class Fetchorders extends OrderEvent {
  final String? searchQuery;
  final String? status;
  Fetchorders({required this.searchQuery, this.status});
}

// woking...
// class FetchOrders extends OrderEvent {
//   final String? searchQuery;
//   final String? status;
//   FetchOrders({this.status, this.searchQuery});
// }
