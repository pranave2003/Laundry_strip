part of 'service_bloc.dart';

@immutable
sealed class ServiceEvent {}

class InstructionEvent extends ServiceEvent {
  final BagInstructionModel bag;
  InstructionEvent({required this.bag});
}

class FetchInstructionEvent extends ServiceEvent {
  final String? searchQuery;
  final String? status;
  FetchInstructionEvent({required this.searchQuery, required this.status});
}

class MaterialAddevent extends ServiceEvent {
  final MaterialModel cloth;
  MaterialAddevent({required this.cloth});
}
