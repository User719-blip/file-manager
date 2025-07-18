import 'package:file_manager/feature/categories/download/data/datasource/file_local_datasource.dart';
import 'package:file_manager/feature/categories/download/domain/entities/download_entities.dart';
import 'package:file_manager/feature/categories/download/domain/repo/file_repo.dart';

class FileRepoImplementation implements FileRepo {
  final FileLocalDatasource dataSource;

  FileRepoImplementation(this.dataSource);

   @override
  Future<List<DownloadEntities>> getDownloadedFiles() {
    return dataSource.getDownloadedFiles();
  }
}