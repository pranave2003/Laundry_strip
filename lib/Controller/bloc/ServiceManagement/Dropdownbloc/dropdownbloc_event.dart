part of 'dropdownbloc_bloc.dart';

@immutable
sealed class DropdownblocEvent {}

class Fetchcatogorybydropdown extends DropdownblocEvent {
  final String? service;

  Fetchcatogorybydropdown({
    this.service,
  });
}
