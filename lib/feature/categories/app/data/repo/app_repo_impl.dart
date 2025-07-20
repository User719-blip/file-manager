

import 'package:file_manager/feature/categories/app/data/datasource/app_datasource.dart';
import 'package:file_manager/feature/categories/app/domain/entity/app_entity.dart';
import 'package:file_manager/feature/categories/app/domain/repo/app_repo.dart';

class AppRepoImpl implements AppRepo {
  final AppLocalDataSource dataSource;

  AppRepoImpl(this.dataSource);

  @override
  Future<List<AppEntity>> getInstalledApps() {
    return dataSource.getInstalledApps();
  }
}
