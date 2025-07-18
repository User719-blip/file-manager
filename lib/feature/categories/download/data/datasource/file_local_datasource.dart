import 'dart:io';

import 'package:file_manager/feature/categories/download/data/model/file_model.dart';
import 'package:file_manager/feature/categories/download/domain/entities/download_entities.dart';

class FileLocalDatasource {
  Future<List<DownloadEntities>> getDownloadedFiles() async {
    // Simulate fetching downloaded files from local storage
    final dir = Directory('/storage/emulated/0/Download'); //add repo provider
    final files = dir.listSync().whereType<File>();
    return files.map((f) => FileModel.fromFile(f)).toList();
  }
}