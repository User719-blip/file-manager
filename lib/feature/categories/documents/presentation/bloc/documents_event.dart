part of 'documents_bloc.dart';

@immutable
sealed class DocumentsEvent {}


class LoadDocumentsEvents extends DocumentsEvent {
  LoadDocumentsEvents();
}