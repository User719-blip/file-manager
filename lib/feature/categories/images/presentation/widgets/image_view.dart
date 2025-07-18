import 'package:file_manager/core/app_loader/loading_indicator.dart';
import 'package:file_manager/core/utils/clipboard_manager.dart';
import 'package:file_manager/core/utils/file_actions.dart';
import 'package:file_manager/feature/categories/images/domain/entities/image_entities.dart';
import 'package:file_manager/feature/categories/images/presentation/bloc/images_bloc.dart';
import 'package:file_manager/feature/categories/images/presentation/widgets/full_screen_image_page.dart';
import 'package:file_manager/shared/widgets/grid_file_gallery_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageView extends StatefulWidget {
  const ImageView({super.key});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  bool isSelectionMode = false;
  Set<int> selectedIndexes = {};

  void toggleSelection(int index) {
    setState(() {
      if (selectedIndexes.contains(index)) {
        selectedIndexes.remove(index);
        if (selectedIndexes.isEmpty) isSelectionMode = false;
      } else {
        selectedIndexes.add(index);
        isSelectionMode = true;
      }
    });
  }

  void clearSelection() {
    setState(() {
      selectedIndexes.clear();
      isSelectionMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSelectionMode
          ? AppBar(
              title: Text('${selectedIndexes.length} selected'),
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: clearSelection,
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final state = context.read<ImagesBloc>().state;
                    if (state is ImageSuccess) {
                      await FileActions.deleteImages(
                        selectedIndexes.map((i) => state.files[i]).toList(),
                      );
                      clearSelection();
                      context.read<ImagesBloc>().add(LoadImageEvents());
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.content_copy),
                  onPressed: () {
                    final state = context.read<ImagesBloc>().state;
                    if (state is ImageSuccess) {
                      final files = selectedIndexes
                          .map((i) => state.files[i])
                          .toList();
                      ClipboardManager<ImageEntity>().copy(files);
                      clearSelection();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.content_cut),
                  onPressed: () {
                    final state = context.read<ImagesBloc>().state;
                    if (state is ImageSuccess) {
                      final files = selectedIndexes
                          .map((i) => state.files[i])
                          .toList();
                      ClipboardManager<ImageEntity>().cut(files);
                      clearSelection();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.paste),
                  onPressed: () async {
                    const targetDir = '/storage/emulated/0/Pictures';
                    await ClipboardManager<ImageEntity>().paste(
                      targetDir,
                      getPath: (e) async {
                        final file = await e.asset.file;
                        return file?.path ?? '';
                      },
                    );
                    context.read<ImagesBloc>().add(LoadImageEvents());
                  },
                ),
              ],
            )
          : AppBar(title: const Text('Images')),
      body: BlocBuilder<ImagesBloc, ImagesState>(
        builder: (context, state) {
          if (state is ImageLoading) {
            return const Center(child: LoadingIndicator());
          } else if (state is ImageSuccess) {
            final images = state.files;
            return GridFileGalleryView(
              files: images,
              onTap: (imageEntity) {
                if (!isSelectionMode) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FullScreenImagePage(image: imageEntity.asset),
                    ),
                  );
                } else {
                  final index = images.indexOf(imageEntity);
                  toggleSelection(index);
                }
              },
              onLongPress: toggleSelection,
              selectedIndexes: selectedIndexes,
              isSelectionMode: isSelectionMode,
            );
          } else if (state is ImageFailure) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No images found.'));
        },
      ),
    );
  }
}
