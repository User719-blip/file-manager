import 'package:bloc/bloc.dart';
import 'package:file_manager/feature/categories/documents/domain/entities/document_entities.dart';
import 'package:file_manager/feature/categories/documents/domain/usecases/get_documents_files.dart';
import 'package:meta/meta.dart';

part 'documents_event.dart';
part 'documents_state.dart';

class DocumentsBloc extends Bloc<DocumentsEvent, DocumentsState> {
  DocumentsBloc(this.useCase) : super(DocumentsInitial()) {
    on<LoadDocumentsEvents>(_onLoadDocumentsEvents);
  }

  final GetDocumentsFiles useCase;

  Future<void> _onLoadDocumentsEvents(
    LoadDocumentsEvents event,
    Emitter<DocumentsState> emit,
  ) async {
    emit(DocumentsLoading());
    try {
      final documents = await useCase();
      emit(DocumentsSuccess(files: documents));
    } catch (e) {
      emit(DocumentsFailure(message: e.toString()));
    }
  }
}
