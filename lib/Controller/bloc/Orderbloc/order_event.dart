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
  final String? userid;
  final String? driverId;

  Fetchorders(
      {required this.searchQuery,
      this.status,
      this.userid,
      this.shopid,
      this.RejectedReason,
      this.Rejected,
      this.Deliverd,
      this.driverId,
      });
}

//Accept order

class Acceptorderevent extends OrderEvent {
  final String? status;
  final String? orderid;
  Acceptorderevent({required this.status, required this.orderid});
}

// Update Working in progress

class Updateworkingprogress extends OrderEvent {
  final String? Progress;
  final String? orderid;
  Updateworkingprogress({required this.Progress, required this.orderid});
}

// Updated
class DeliverdUpdate extends OrderEvent {
  final String? Deliverd;
  final String? orderid;
  DeliverdUpdate({required this.Deliverd, required this.orderid});
}

class Assigndriver extends OrderEvent {
  final String? orderid;
  final String? driverid;
  final String? drivername;
  final String? drivernumber;
  final String? PIckup;
  Assigndriver(
      {required this.PIckup,
      required this.orderid,
      required this.driverid,
      required this.drivername,
      required this.drivernumber});
}
