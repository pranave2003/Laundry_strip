part of 'dropdownbloc_bloc.dart';

@immutable
sealed class DropdownblocEvent {}

class Fetchcatogorybydropdown extends DropdownblocEvent {
  final String? service;

  Fetchcatogorybydropdown({
    this.service,
  });
}

class Fetchshopproductcatogory_inuser extends DropdownblocEvent {
  final String? service;
  final String? shopid;

  Fetchshopproductcatogory_inuser({
    this.service,
    this.shopid,
  });
}
