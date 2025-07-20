import 'package:device_apps/device_apps.dart';
import 'package:file_manager/feature/categories/app/data/model/app_model.dart';


class AppLocalDataSource {
 Future<List<AppModel>> getInstalledApps() async {
  final apps = await DeviceApps.getInstalledApplications(
    includeSystemApps: true,
    includeAppIcons: true,
  );

  // Filter for apps that have icons
  final appsWithIcon = apps.whereType<ApplicationWithIcon>();

  return appsWithIcon.map((app) {
    return AppModel(
      name: app.appName,
      packageName: app.packageName,
      version: app.versionName ?? 'N/A',
      icon: app.icon, // this is Uint8List
    );
  }).toList();
}

}
