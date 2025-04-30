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
  final String? Picked;
  final String? Review;
  final String? RatingStatus;


  Fetchorders({
    required this.searchQuery,
    this.status,
    this.userid,
    this.shopid,
    this.RejectedReason,
    this.Rejected,
    this.Deliverd,
    this.Picked,
    this.driverId,
    this.Review,
    this.RatingStatus,
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
  final String? pickup;
  final String? orderid;
  Updateworkingprogress({required this.Progress, required this.orderid,required this.pickup});
}

// Updated
class DeliverdUpdate extends OrderEvent {
  final String? Deliverd;
  final String? orderid;
  DeliverdUpdate({required this.Deliverd, required this.orderid});
}

class pickupdelivery extends OrderEvent {
  final String? pickup;
  final String? orderid;
  pickupdelivery({required this.pickup, required this.orderid});
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

class Deliverd_scann_event extends OrderEvent {
  final String? orderid;
  final String? Deliverd;
  final String? picked;
  Deliverd_scann_event({required this.orderid, this.Deliverd, this.picked});
}



class FetchOrderDetailsById extends OrderEvent {

  final String? orderid;
  FetchOrderDetailsById({required this.orderid});
}


class UserSendreviewandratingevent extends OrderEvent {
  final String? orderid;
  final String? Review;
  final String? Ratingstatus;
  UserSendreviewandratingevent(
      {required this.orderid,
        this.Review,
        this.Ratingstatus,});
}


