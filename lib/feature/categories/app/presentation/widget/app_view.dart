import 'package:device_apps/device_apps.dart';
import 'package:file_manager/core/app_loader/loading_indicator.dart';
import 'package:file_manager/core/utils/file_actions.dart';
import 'package:file_manager/feature/categories/app/domain/entity/app_entity.dart';
import 'package:file_manager/feature/categories/app/presentation/bloc/app_bloc.dart';
import 'package:file_manager/shared/selection/cubit/selection_cubit.dart';
import 'package:file_manager/shared/widgets/stack_file_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
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
                    final state = context.read<AppBloc>().state;
                    if (state is AppSuccess) {
                      final selectedApps = selectedIndexes
                          .map((index) => state.files[index])
                          .toList();
                      await FileActions.uninstallApps(
                        selectedApps.map((app) => app.packageName).toList(),
                      );
                      // ignore: use_build_context_synchronously
                      context
                          .read<SelectionCubit<AppEntity>>()
                          .clearSelection();
                      // ignore: use_build_context_synchronously
                      context.read<AppBloc>().add(LoadAppEvent());
                    }
                  },
                ),
              ],
            )
          : AppBar(title: const Text('Apps')),
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state is AppLoading) {
            return const Center(child: LoadingIndicator());
          }
          if (state is AppSuccess) {
            return StackFileListView(
              fileName: state.files.map((e) => e.name).toList(),
              fileIcon: state.files.map((e) => e.icon).toList(),
              selectedIndexes: selectedIndexes,
              isSelectionMode: isSelectionMode,
              onTap: (index) {
                final app = state.files[index];
                DeviceApps.openApp(app.packageName);
              },
              onLongPress: (index) => toggleSelection(index),
            );
          }
          if (state is AppFailure) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No App found.'));
        },
      ),
    );
  }
}
