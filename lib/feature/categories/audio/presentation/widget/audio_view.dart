import 'package:file_manager/core/app_loader/loading_indicator.dart';
import 'package:file_manager/core/utils/clipboard_manager.dart';
import 'package:file_manager/core/utils/file_actions.dart';
import 'package:file_manager/feature/categories/audio/domain/entity/audio_entity.dart';
import 'package:file_manager/feature/categories/audio/presentation/bloc/audio_bloc.dart';
import 'package:file_manager/shared/selection/cubit/selection_cubit.dart';
import 'package:file_manager/shared/widgets/stack_file_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';

class AudioView extends StatefulWidget {
  const AudioView({super.key});

  @override
  State<AudioView> createState() => _AudioViewState();
}

class _AudioViewState extends State<AudioView> {
  Set<int> selectedIndexes = {};

  bool isSelectionMode = false;

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
                    final state = context.read<AudioBloc>().state;
                    if (state is AudioSuccess) {
                      await FileActions.deleteFiles(
                        selectedIndexes
                            .map((index) => state.files[index])
                            .toList(),
                      );
                      // ignore: use_build_context_synchronously
                      context
                          .read<SelectionCubit<AudioEntity>>()
                          .clearSelection();
                      // ignore: use_build_context_synchronously
                      context.read<AudioBloc>().add(LoadAudioEvent());
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.content_copy),
                  onPressed: () {
                    final state = context.read<AudioBloc>().state;
                    if (state is AudioSuccess) {
                      final files = selectedIndexes
                          .map((index) => state.files[index])
                          .toList();
                      ClipboardManager<AudioEntity>().copy(files);
                      clearSelection();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.content_cut),
                  onPressed: () {
                    final state = context.read<AudioBloc>().state;
                    if (state is AudioSuccess) {
                      final files = selectedIndexes
                          .map((index) => state.files[index])
                          .toList();
                      ClipboardManager<AudioEntity>().cut(files);
                      clearSelection();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.paste),
                  onPressed: () async {
                    final targetDir =
                        '/storage/emulated/0/Audio'; // or use file.path of current dir
                    await ClipboardManager<AudioEntity>().paste(
                      targetDir,
                      getPath: (e) async => e.path,
                    );
                    // ignore: use_build_context_synchronously
                    context.read<AudioBloc>().add(LoadAudioEvent());
                  },
                ),
                
              ],
            )
          : AppBar(title: const Text('Audio')),
      body: BlocBuilder<AudioBloc, AudioState>(
        builder: (context, state) {
          if (state is AudioLoading) {
            return const LoadingIndicator();
          }
          if (state is AudioSuccess) {
            return StackFileListView(
              fileName: state.files.map((e) => e.title).toList(),
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
          if (state is AudioFailure) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No Audio found.'));
        },
      ),
    );
  }
}
