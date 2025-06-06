part of 'service_bloc.dart';

@immutable
sealed class ServiceEvent {}

// class FetchInstructionEvent extends ServiceEvent {
//   final String? searchQuery;
//   final String? status;
//   FetchInstructionEvent({required this.searchQuery, required this.status});
// }

class MaterialAddevent extends ServiceEvent {
  final MaterialModel cloth;
  MaterialAddevent({required this.cloth});
}

class FetchMaterial extends ServiceEvent {
  final String? searchQuery;
  FetchMaterial({required this.searchQuery});
}

class InstructionAddEvent extends ServiceEvent {
  final InstructionModel instruction;
  InstructionAddEvent({required this.instruction});
}

class FetchInstruction extends ServiceEvent {
  final String? searchQuery;
  FetchInstruction({required this.searchQuery});
}

class CategoryAddEvent extends ServiceEvent {
  final CategoryModel category;
  CategoryAddEvent({required this.category});
}

class FetchCategory extends ServiceEvent {
  final String? searchQuery;
  FetchCategory({required this.searchQuery});
}

class DeleteCategory extends ServiceEvent {
  final String? id;
  DeleteCategory({required this.id});
}

class DeleteMaterial extends ServiceEvent {
  final String? id;
  DeleteMaterial({required this.id});
}

class DeleteInstruction extends ServiceEvent {
  final String? id;
  DeleteInstruction({required this.id});
}

// class Fetchcatogorybydropdown extends ServiceEvent {}

class Fetchcatogoryimagesevent extends ServiceEvent {
  final String? searchQuery;
  final String? Catogoty;
  final String? Servicetype;
  Fetchcatogoryimagesevent(
      {required this.searchQuery, this.Catogoty, this.Servicetype});
}


class EditCategory extends ServiceEvent {
  final CategoryModel category;
  EditCategory({required this.category});
}

class EditMaterial extends ServiceEvent {
  final MaterialModel cloth;
  EditMaterial({required this.cloth});
}
class EditInstruction extends ServiceEvent {
  final InstructionModel instruction;
  EditInstruction({required this.instruction});
}