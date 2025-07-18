import 'package:file_manager/feature/categories/images/domain/entities/image_entities.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageModel extends ImageEntity {
  ImageModel({
    required super.id,
    required super.title,
    required super.filePath,
    required super.createdAt,
    required super.asset,
  });

  factory ImageModel.fromAssetEntity(AssetEntity entity) {
    return ImageModel(
      id: entity.id,
      title: entity.title ?? '',
      filePath: entity.relativePath ?? '',
      createdAt: entity.createDateTime,
      asset: entity,
    );
  }
}
