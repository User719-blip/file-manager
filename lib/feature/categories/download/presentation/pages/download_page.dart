import 'package:file_manager/feature/categories/download/data/datasource/file_local_datasource.dart';
import 'package:file_manager/feature/categories/download/data/repo/file_repo_implementation.dart';
import 'package:file_manager/feature/categories/download/domain/usecase/get_download_files.dart';
import 'package:file_manager/feature/categories/download/presentation/bloc/download_bloc.dart';
import 'package:file_manager/feature/categories/download/presentation/widgets/download_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) { 
        final dataSource = FileLocalDatasource();
        final fileRepository = FileRepoImplementation(dataSource);
        final useCase = GetDownloadFiles(fileRepository: fileRepository);
        return  DownloadBloc(useCase)..add(LoadDownloadEvent());
      },
      child: const DownloadsView(),
    );
  }
}
