import 'package:file_manager/feature/categories/images/data/data_sources/image_source.dart';
import 'package:file_manager/feature/categories/images/domain/entities/image_entities.dart';
import 'package:file_manager/feature/categories/images/domain/repo/image_repo.dart';

class ImageRepoImpl implements ImageRepo{
  final ImageDataSource dataSource;

  ImageRepoImpl(this.dataSource);

  @override
  Future<List<ImageEntity>> getImages() {
    return dataSource.fetchImage();
  }

}