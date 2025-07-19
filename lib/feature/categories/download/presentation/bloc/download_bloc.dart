import 'package:bloc/bloc.dart';
import 'package:file_manager/feature/categories/download/domain/entities/download_entities.dart';
import 'package:file_manager/feature/categories/download/domain/usecase/get_download_files.dart';
import 'package:meta/meta.dart';

part 'download_event.dart';
part 'download_state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  DownloadBloc(this.useCase) : super(DownloadInitial()) {
    on<LoadDownloadEvent>(_onLoadDownloadEvent);
  }

  final GetDownloadFiles useCase;

  Future<void> _onLoadDownloadEvent(
    LoadDownloadEvent event,
    Emitter<DownloadState> emit,
  ) async {
    emit(DownloadLoading());
    try {
      // Simulate fetching downloaded files
      final files = await useCase();
      emit(DownloadSuccess(files: files));
    } catch (e) {
      emit(DownloadFailure(message: e.toString()));
    } 
  }
}
