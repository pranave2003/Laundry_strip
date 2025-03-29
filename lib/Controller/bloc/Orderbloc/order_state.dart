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

class orderloaded extends OrderState {
  final List<OrderModel> order;

  orderloaded(
    this.order,
  );
}
