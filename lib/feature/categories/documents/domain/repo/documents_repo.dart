import 'package:file_manager/feature/categories/documents/domain/entities/document_entities.dart';

abstract class DocumentsRepo {
  Future<List<DocumentsEntity>> getDocuments();
}