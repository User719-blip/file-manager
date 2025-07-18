
import 'package:file_manager/feature/categories/download/domain/entities/download_entities.dart';
import 'package:file_manager/feature/categories/download/domain/repo/file_repo.dart';

class GetDownloadFiles {
  final FileRepo  fileRepository;

  GetDownloadFiles({required this.fileRepository});
  
 

  Future<List<DownloadEntities>> call() {
    return fileRepository.getDownloadedFiles();
  }

}

