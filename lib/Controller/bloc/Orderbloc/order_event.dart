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
  final String? Rejected;
  final String? RejectedReason;
  final String? Deliverd;
  final String? shopid;

  Fetchorders(
      {required this.searchQuery,
      this.status,
      this.shopid,
      this.RejectedReason,
      this.Rejected,
      this.Deliverd});
}

//Accept order

class Acceptorderevent extends OrderEvent {
  final String? status;
  final String? orderid;
  Acceptorderevent({required this.status, required this.orderid});
}
