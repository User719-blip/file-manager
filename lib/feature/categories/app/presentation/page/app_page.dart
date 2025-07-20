import 'package:file_manager/feature/categories/app/data/datasource/app_datasource.dart';
import 'package:file_manager/feature/categories/app/data/repo/app_repo_impl.dart';
import 'package:file_manager/feature/categories/app/domain/usecase/get_app_files.dart';
import 'package:file_manager/feature/categories/app/presentation/bloc/app_bloc.dart';
import 'package:file_manager/feature/categories/app/presentation/widget/app_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final dataSource = AppLocalDataSource();
        final audioRepository = AppRepoImpl(dataSource);
        final useCase = GetInstalledApps(repo: audioRepository);
        return AppBloc(useCase)..add(LoadAppEvent());
      },
      child: AppView(),
    );
  }
}
