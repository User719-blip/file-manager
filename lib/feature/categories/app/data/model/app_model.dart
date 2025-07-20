
import 'package:file_manager/feature/categories/app/domain/entity/app_entity.dart';

class AppModel extends AppEntity {
  AppModel({
    required super.name,
    required super.packageName,
    required super.version,
    super.icon,
  });

  AppEntity toEntity() => this;

  factory AppModel.fromApplication(app) {
    return AppModel(
      name: app.appName,
      packageName: app.packageName,
      version: app.versionName ?? 'N/A',
      icon: app.icon,
    );
  }
}
