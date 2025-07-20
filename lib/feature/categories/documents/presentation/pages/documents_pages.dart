import 'package:file_manager/feature/categories/documents/data/datasource/documents_datasource.dart';
import 'package:file_manager/feature/categories/documents/data/repo/documets_repo_implemetation.dart';
import 'package:file_manager/feature/categories/documents/domain/usecases/get_documents_files.dart';
import 'package:file_manager/feature/categories/documents/presentation/bloc/documents_bloc.dart';
import 'package:file_manager/feature/categories/documents/presentation/widgets/documents_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocumentsPages extends StatelessWidget {
  const DocumentsPages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final dataSource = DocumentsDataSource();
        final documentsRepository = DocumentsRepositoryImpl(dataSource: dataSource);
        final useCase = GetDocumentsFiles(documentsRepository: documentsRepository);
        return  DocumentsBloc(useCase)..add(LoadDocumentsEvents());
      },
      child: DocumentsView(),
    );
  }
}
