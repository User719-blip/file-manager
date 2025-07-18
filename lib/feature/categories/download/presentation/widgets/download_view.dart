import 'package:file_manager/core/app_loader/loading_indicator.dart';
import 'package:file_manager/core/utils/clipboard_manager.dart';
import 'package:file_manager/core/utils/file_actions.dart';
import 'package:file_manager/feature/categories/download/domain/entities/download_entities.dart';
import 'package:file_manager/feature/categories/download/presentation/bloc/download_bloc.dart';
import 'package:file_manager/shared/selection/cubit/selection_cubit.dart';
import 'package:file_manager/shared/widgets/stack_file_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';

class DownloadsView extends StatefulWidget {
  const DownloadsView({super.key});

  @override
  State<DownloadsView> createState() => _DownloadsViewState();
}

class _DownloadsViewState extends State<DownloadsView> {
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
                    final state = context.read<DownloadBloc>().state;
                    if (state is DownloadSuccess) {
                      await FileActions.deleteFiles(
                        selectedIndexes
                            .map((index) => state.files[index])
                            .toList(),
                      );
                      // ignore: use_build_context_synchronously
                      context
                          .read<SelectionCubit<DownloadEntities>>()
                          .clearSelection();
                      // ignore: use_build_context_synchronously
                      context.read<DownloadBloc>().add(LoadDownloadEvent());
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.content_copy),
                  onPressed: () {
                    final state = context.read<DownloadBloc>().state;
                    if (state is DownloadSuccess) {
                      final files = selectedIndexes
                          .map((index) => state.files[index])
                          .toList();
                      ClipboardManager<DownloadEntities>().copy(files);
                      clearSelection();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.content_cut),
                  onPressed: () {
                    final state = context.read<DownloadBloc>().state;
                    if (state is DownloadSuccess) {
                      final files = selectedIndexes
                          .map((index) => state.files[index])
                          .toList();
                      ClipboardManager<DownloadEntities>().cut(files);
                      clearSelection();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.paste),
                  onPressed: () async {
                    final targetDir =
                        '/storage/emulated/0/Download'; // or use file.path of current dir
                    await ClipboardManager<DownloadEntities>().paste(
                      targetDir,
                      getPath: (e) async => e.path,
                    );
                    // ignore: use_build_context_synchronously
                    context.read<DownloadBloc>().add(LoadDownloadEvent());
                  },
                ),
              ],
            )
          : AppBar(title: const Text('Downloads')),
      body: BlocBuilder<DownloadBloc, DownloadState>(
        builder: (context, state) {
          if (state is DownloadLoading) {
            return const LoadingIndicator();
          }
          if (state is DownloadSuccess) {
            return StackFileListView(
              fileName: state.files.map((e) => e.name).toList(),
              selectedIndexes: selectedIndexes,
              isSelectionMode: isSelectionMode,
              onTap: (index) {
                if (isSelectionMode) {
                  toggleSelection(index);
                } else {
                  final file = state.files[index];
                  OpenFile.open(file.path);
                }
              },
              onLongPress: (index) => toggleSelection(index),
            );
          }
          if (state is DownloadFailure) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No downloads found.'));
        },
      ),
    );
  }
}
