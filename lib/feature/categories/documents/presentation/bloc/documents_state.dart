part of 'documents_bloc.dart';

@immutable
sealed class DocumentsState {}

final class DocumentsInitial extends DocumentsState {}

final class DocumentsLoading extends DocumentsState {}

final class DocumentsSuccess extends DocumentsState {
  
  final List<DocumentsEntity> files;

  DocumentsSuccess({required this.files});
}

final class DocumentsFailure extends DocumentsState {
  final String? message;

  DocumentsFailure({required this.message});
}