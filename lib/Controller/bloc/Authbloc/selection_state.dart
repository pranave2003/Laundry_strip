abstract class SelectionState {}

class SelectionInitial extends SelectionState {}

class SelectionUpdated extends SelectionState {
  final Map<String, String> selections;

  SelectionUpdated(this.selections);
}