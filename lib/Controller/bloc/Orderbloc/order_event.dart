part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class placeorder extends OrderEvent {
  final OrderModel order;
  placeorder(this.order);
}
class Fetchorders extends OrderEvent {
  final String? searchQuery;
  Fetchorders({required this.searchQuery});

}