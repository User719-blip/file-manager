import 'package:file_manager/shared/selection/selection_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectionCubit<T> extends Cubit<SelectionModel<T>> {
  SelectionCubit() : super(SelectionModel());

  void toggleSelection(T item) {
    final items = [...state.selectedItems];
    if (items.contains(item)) {
      items.remove(item);
    } else {
      items.add(item);
    }

    emit(SelectionModel(
      selectedItems: items,
      isSelecting: items.isNotEmpty,
    ));
  }

  void clearSelection() {
    emit(SelectionModel(selectedItems: [], isSelecting: false));
  }
}
