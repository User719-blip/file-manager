import 'dart:io';

import 'package:file_manager/feature/categories/documents/data/model/documents_model.dart';

import 'package:path/path.dart' as p;

class DocumentsDataSource {
  final List<String> allowedExtensions = [
    '.pdf', '.docx', '.doc', '.txt', '.xlsx', '.ppt', '.pptx'
  ];

  Future<List<DocumentModel>> getAllDocumentModels() async {
    final Directory storage = Directory('/storage/emulated/0/');
    final List<FileSystemEntity> files = storage
        .listSync(recursive: true, followLinks: false)
        .whereType<File>()
        .toList();

    final documentFiles = files.where((file) {
      final ext = p.extension(file.path).toLowerCase();
      return allowedExtensions.contains(ext);
    });

    return documentFiles.map((file) => DocumentModel.fromFile(file as File)).toList();
  }
}
