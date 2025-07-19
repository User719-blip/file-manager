import 'package:file_manager/core/app_loader/loading_indicator.dart';
import 'package:file_manager/core/utils/clipboard_manager.dart';
import 'package:file_manager/core/utils/file_actions.dart';
import 'package:file_manager/feature/categories/documents/domain/entities/document_entities.dart';
import 'package:file_manager/feature/categories/documents/presentation/bloc/documents_bloc.dart';
import 'package:file_manager/shared/selection/cubit/selection_cubit.dart';
import 'package:file_manager/shared/widgets/stack_file_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';

// ignore: must_be_immutable
class DocumentsView extends StatefulWidget {

  const DocumentsView({super.key});

  @override
  State<DocumentsView> createState() => _DocumentsViewState();
}

class _DocumentsViewState extends State<DocumentsView> {
  bool isSelectionMode = false ;

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
      appBar:  isSelectionMode
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
                    final state = context.read<DocumentsBloc>().state;
                    if (state is DocumentsSuccess) {
                      await FileActions.deleteFiles(
                        selectedIndexes
                            .map((index) => state.files[index])
                            .toList(),
                      );
                      // ignore: use_build_context_synchronously
                      context
                          .read<SelectionCubit<DocumentsEntity>>()
                          .clearSelection();
                      // ignore: use_build_context_synchronously
                      context.read<DocumentsBloc>().add(LoadDocumentsEvents());
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.content_copy),
                  onPressed: () {
                    final state = context.read<DocumentsBloc>().state;
                    if (state is DocumentsSuccess) {
                      final files = selectedIndexes
                          .map((index) => state.files[index])
                          .toList();
                      ClipboardManager<DocumentsEntity>().copy(files);
                      clearSelection();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.content_cut),
                  onPressed: () {
                    final state = context.read<DocumentsBloc>().state;
                    if (state is DocumentsSuccess) {
                      final files = selectedIndexes
                          .map((index) => state.files[index])
                          .toList();
                      ClipboardManager<DocumentsEntity>().cut(files);
                      clearSelection();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.paste),
                  onPressed: () async {
                    final targetDir =
                        '/storage/emulated/0/Documents'; // or use file.path of current dir
                    await ClipboardManager<DocumentsEntity>().paste(
                      targetDir,
                      getPath: (e) async => e.path,
                    );
                    // ignore: use_build_context_synchronously
                    context.read<DocumentsBloc>().add(LoadDocumentsEvents());
                  },
                ),
              ],
            )
          :AppBar(title: const Text('Documents')),
      body: BlocBuilder<DocumentsBloc, DocumentsState>(
        builder: (context, state) {
          if (state is DocumentsLoading) {
            return LoadingIndicator();
          }
          if (state is DocumentsSuccess) {
            return StackFileListView(
              fileName: state.files.map((e) => e.name).toList(),
              selectedIndexes:selectedIndexes,
              isSelectionMode: isSelectionMode,
              onTap: (index) {
                if (isSelectionMode) {
                  toggleSelection(index);
                } else {
                  final file = state.files[index];
                  OpenFile.open(file.path);
                }
              },
              onLongPress: (index)  => toggleSelection(index),
            );
          }
          if (state is DocumentsFailure) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No documents found.'));
        },
      ),
    );
  }
}
