import 'package:file_manager/feature/categories/images/domain/entities/image_entities.dart';

abstract class ImageRepo{
  Future<List<ImageEntity>> getImages();
}