import 'package:flutter_bloc/flutter_bloc.dart';
import 'selection_state.dart';

class SelectionCubit extends Cubit<SelectionState> {
  SelectionCubit() : super(SelectionInitial());

  final Map<String, String> selections = {};

  void updateSelection(String key, String value) {
    selections[key] = value;
    emit(SelectionUpdated(Map.from(selections))); // Emit updated state
  }
}