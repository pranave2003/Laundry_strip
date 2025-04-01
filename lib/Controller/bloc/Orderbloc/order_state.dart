part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class orderverLoading extends OrderState {}

final class orderSuccess extends OrderState {}

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