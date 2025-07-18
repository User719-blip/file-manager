import 'dart:io';

import 'package:file_manager/feature/categories/download/domain/entities/download_entities.dart';

class FileModel extends DownloadEntities {
  FileModel({required super.path, required super.name, required super.size});
  

  factory FileModel.fromFile(File file) {
    final stat = file.statSync();
    return FileModel(
      name: file.uri.pathSegments.last,
      path: file.path,
      size: stat.size,
    );
  }

}
