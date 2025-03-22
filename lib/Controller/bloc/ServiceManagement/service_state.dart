part of 'service_bloc.dart';

@immutable
sealed class ServiceState {}

final class ServiceInitial extends ServiceState {}

final class Loading extends ServiceState {}

final class meterialSuccess extends ServiceState {}

final class failerror extends ServiceState {
  final String error;

  failerror(this.error);
}
