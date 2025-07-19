
import 'package:file_manager/feature/categories/documents/data/datasource/documents_datasource.dart';
import 'package:file_manager/feature/categories/documents/domain/entities/document_entities.dart';
import 'package:file_manager/feature/categories/documents/domain/repo/documents_repo.dart';

class DocumentsRepositoryImpl implements DocumentsRepo {
  final DocumentsDataSource dataSource;

  DocumentsRepositoryImpl({required this.dataSource});

  @override
  Future<List<DocumentsEntity>> getDocuments() async {
    final models = await dataSource.getAllDocumentModels();
    return models.map((model) => model.toEntity()).toList();
  }
}
