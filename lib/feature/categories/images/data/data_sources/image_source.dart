import 'package:file_manager/feature/categories/images/data/model/image_model.dart';
import 'package:file_manager/feature/categories/images/domain/entities/image_entities.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageDataSource {
  Future<List<ImageEntity>> fetchImage() async{
    final result = await PhotoManager.requestPermissionExtend();
    if(!result.isAuth) return [];
    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
    );
    
    final List<AssetEntity> photos = await albums.first.getAssetListPaged(page: 0, size: 100);

    return photos.map((e) => ImageModel.fromAssetEntity(e)).toList();
  }
}