import 'dart:typed_data';
import 'package:file_manager/feature/categories/images/domain/entities/image_entities.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class GridFileGalleryView extends StatelessWidget {
  final List<ImageEntity> files;
  final void Function(ImageEntity) onTap;
  final void Function(int) onLongPress;
  final Set<int> selectedIndexes;
  final bool isSelectionMode;

  const GridFileGalleryView({
    super.key,
    required this.files,
    required this.onTap,
    required this.onLongPress,
    required this.selectedIndexes,
    required this.isSelectionMode,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: files.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final image = files[index];
        final isSelected = selectedIndexes.contains(index);

        return GestureDetector(
          onTap: () => onTap(image),
          onLongPress: () => onLongPress(index),
          child: Stack(
            children: [
              FutureBuilder<Uint8List?>(
                future: image.asset.thumbnailDataWithSize(
                  const ThumbnailSize(200, 200),
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 1),
                    );
                  } else if (snapshot.hasData) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(snapshot.data!, fit: BoxFit.cover),
                    );
                  } else {
                    return const Center(child: Icon(Icons.broken_image));
                  }
                },
              ),
              if (isSelectionMode)
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? Colors.blue : Colors.grey.shade200,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                      size: 20,
                      color: isSelected ? Colors.white : Colors.black54,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
