import 'dart:typed_data';

class AppEntity {
  final String name;
  final String packageName;
  final String version;
  final Uint8List? icon; // Use raw icon bytes

  AppEntity({
   this.icon,
    required this.name,
    required this.packageName,
    required this.version,
  });
}
