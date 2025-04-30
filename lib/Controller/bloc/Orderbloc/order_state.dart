part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class orderverLoading extends OrderState {}

final class orderSuccess extends OrderState {}

final class orderRefresh extends OrderState {}

final class ActionLoading extends OrderState {}

final class orderFailure extends OrderState {
  final String error;

  orderFailure(this.error);
}

////
final class orderfetchloading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<OrderModel> orders;
  OrderLoaded(this.orders);
}

class OrderFailure extends OrderState {
  final String message;
  OrderFailure(this.message);
}

class scanndeliverdLoading extends OrderState {}

class Scannersuccess extends OrderState {}

class Deliverderror extends OrderState {
  final String error;
  Deliverderror({required this.error});
}

class orderloadingbyid extends OrderState {}

final class OrderByidLoaded extends OrderState {
  final OrderModel order;
  OrderByidLoaded(this.order);
}

final class Ordererror extends OrderState {
  final String error;
  Ordererror({required this.error});
}
//UserSendreviewandratingSuccess_State//

final class UserSendreviewandratingSuccess extends OrderState {}

final class UserSendreviewandratingfailerror extends OrderState {
  final String error;

  UserSendreviewandratingfailerror(this.error);
}
final class UserSendreviewandratingloading extends OrderState {}

final class UserSendreviewandratingRefresh extends OrderState {}

// States for fetching feedback
// States for fetching feedback
class UserFeedbackLoading extends OrderState {}



class FeedbackLoaded extends OrderState {
  final List<OrderModel> orders;
  FeedbackLoaded(this.orders);
}
