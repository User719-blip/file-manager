
import 'package:file_manager/feature/categories/app/domain/entity/app_entity.dart';

abstract class AppRepo {
  Future<List<AppEntity>> getInstalledApps();
}
