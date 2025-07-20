// domain/usecases/get_installed_apps.dart

import 'package:file_manager/feature/categories/app/domain/entity/app_entity.dart';
import 'package:file_manager/feature/categories/app/domain/repo/app_repo.dart';

class GetInstalledApps {
  final AppRepo repo;

  GetInstalledApps({required this.repo});

  Future<List<AppEntity>> call() async {
    return await repo.getInstalledApps();
  }
}
