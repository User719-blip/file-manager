import 'package:photo_manager/photo_manager.dart';

class ImageEntity {
  final String id;
  final String title;
  final String filePath;
  final DateTime createdAt;
  final AssetEntity asset;

  ImageEntity({
    required this.asset, 
    required this.id,
    required this.title,
    required this.filePath,
    required this.createdAt,
  });
}
