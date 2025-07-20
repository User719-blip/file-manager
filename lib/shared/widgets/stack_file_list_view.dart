import 'dart:typed_data';
import 'package:flutter/material.dart';

class StackFileListView extends StatelessWidget {
  final List<String> fileName;
  final Set<int> selectedIndexes;
  final bool isSelectionMode;
  final void Function(int) onTap;
  final void Function(int) onLongPress;
  final List<Uint8List?> fileIcon;

  const StackFileListView({
    super.key,
    this.fileIcon = const <Uint8List?>[],
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

        Widget leadingIcon;
        if (isSelected) {
          leadingIcon = const Icon(Icons.check_circle, color: Colors.blue);
        } else if (fileIcon.isNotEmpty && fileIcon.length > index && fileIcon[index] != null) {
          leadingIcon = Image.memory(
            fileIcon[index]!,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          );
        } else {
          leadingIcon = const Icon(Icons.insert_drive_file);
        }

        return ListTile(
          leading: leadingIcon,
          title: Text(
            fileName[index],
            style: TextStyle(
              color: isSelected ? Colors.blue : null,
              fontWeight: isSelected ? FontWeight.bold : null,
            ),
          ),
          onTap: () => onTap(index),
          onLongPress: () => onLongPress(index),
          tileColor: isSelected ? Colors.blue.withOpacity(0.2) : null,
        );
      },
    );
  }
}
