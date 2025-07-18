import 'package:file_manager/feature/categories/download/domain/entities/download_entities.dart';

abstract class FileRepo {
  Future<List<DownloadEntities>> getDownloadedFiles();
}