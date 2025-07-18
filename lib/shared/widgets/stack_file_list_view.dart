import 'package:flutter/material.dart';

class StackFileListView extends StatelessWidget {
  final List<String> fileName;
  final Set<int> selectedIndexes;
  final bool isSelectionMode;
  final void Function(int) onTap;
  final void Function(int) onLongPress;

  const StackFileListView({
    super.key,
    required this.fileName,
    required this.selectedIndexes,
    required this.isSelectionMode,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: fileName.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final isSelected = selectedIndexes.contains(index);
        return ListTile(
          leading: Icon(
            isSelected ? Icons.check_circle : Icons.insert_drive_file,
            color: isSelected ? Colors.blue : null,
          ),
          title: Text(
            fileName[index],
            style: TextStyle(
              color: isSelected ? Colors.blue : null,
              fontWeight: isSelected ? FontWeight.bold : null,
            ),
          ),
          onTap: () => onTap(index),
          onLongPress: () => onLongPress(index),
          // ignore: deprecated_member_use
          tileColor: isSelected ? Colors.blue.withOpacity(0.2) : null,
        );
      },
    );
  }
}
