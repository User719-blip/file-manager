class SelectionModel<T> {
  final List<T> selectedItems;
  final bool isSelecting;

  SelectionModel({this.selectedItems = const [], this.isSelecting = false});
}
