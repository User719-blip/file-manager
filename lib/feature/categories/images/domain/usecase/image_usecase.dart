import 'package:file_manager/feature/categories/images/domain/entities/image_entities.dart';
import 'package:file_manager/feature/categories/images/domain/repo/image_repo.dart';

class GetImages {
  final ImageRepo imageRepo;

  GetImages({required this.imageRepo});

  Future<List<ImageEntity>> call(){
    return imageRepo.getImages();
  }
}