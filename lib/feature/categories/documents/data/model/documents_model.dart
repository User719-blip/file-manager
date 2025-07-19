import 'dart:io';
import 'package:path/path.dart' as p;
import '../../domain/entities/document_entities.dart';

class DocumentModel {
  final String id;
  final String name;
  final String path;
  final int size;

  DocumentModel({
    required this.id,
    required this.name,
    required this.path,
    required this.size,
  });

  /// From a FileSystemEntity (i.e. dart:io file)
  factory DocumentModel.fromFile(File file) {
    final stat = file.statSync();
    return DocumentModel(
      id: file.path,
      name: p.basename(file.path),
      path: file.path,
      size: stat.size,
    );
  }

  /// Convert to Domain Entity
  DocumentsEntity toEntity() => DocumentsEntity(
        id: id,
        name: name,
        path: path,
        size: size, 
        
      );
}
