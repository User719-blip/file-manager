import 'package:file_manager/feature/categories/documents/domain/entities/document_entities.dart';
import 'package:file_manager/feature/categories/documents/domain/repo/documents_repo.dart';

class GetDocumentsFiles {
  final DocumentsRepo documentsRepository;

  GetDocumentsFiles({required this.documentsRepository});

  Future<List<DocumentsEntity>> call() {
    return documentsRepository.getDocuments();
  }
}