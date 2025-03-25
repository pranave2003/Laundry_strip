part of 'service_bloc.dart';

@immutable
sealed class ServiceState {}

final class ServiceInitial extends ServiceState {}

// material
final class Loading extends ServiceState {}

final class meterialSuccess extends ServiceState {}

final class failerror extends ServiceState {
  final String error;

  failerror(this.error);
}
class Materialloaded extends ServiceState {
  final List<MaterialModel> cloth;

  Materialloaded(
      this.cloth,
      );
}
// instruction
final class InstructionLoading extends ServiceState {}

final class InstructionSuccess extends ServiceState {}

final class Instructionfailerror extends ServiceState {
  final String error;

  Instructionfailerror(this.error);
}
class Instructionloaded extends ServiceState {
  final List<InstructionModel> instruction;

  Instructionloaded(
      this.instruction,
      );
}

// category
final class CategoryLoading extends ServiceState {}

final class CategorySuccess extends ServiceState {}

final class Categoryfailerror extends ServiceState {
  final String error;

  Categoryfailerror(this.error);
}
class Categoryloaded extends ServiceState {
  final List<CategoryModel> category;

  Categoryloaded(
      this.category,
      );

}
class RefreshCategory extends ServiceState {
}
class RefreshMaterial extends ServiceState {
}
class RefreshInstruction extends ServiceState {

}
