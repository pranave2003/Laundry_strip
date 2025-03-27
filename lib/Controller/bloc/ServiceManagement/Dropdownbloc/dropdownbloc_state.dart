part of 'dropdownbloc_bloc.dart';

@immutable
sealed class DropdownblocState {}

final class DropdownblocInitial extends DropdownblocState {}

class fetchcatogorydropdownloading extends DropdownblocState {}

class catogoryLoadedDOMAIN extends DropdownblocState {
  final List<String> catogory;
  catogoryLoadedDOMAIN(this.catogory);
}

class FetchcatogotyError extends DropdownblocState {
  final String msg;
  FetchcatogotyError(this.msg);
}
