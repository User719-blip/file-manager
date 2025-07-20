import 'package:bloc/bloc.dart';
import 'package:file_manager/feature/categories/audio/domain/entity/audio_entity.dart';
import 'package:file_manager/feature/categories/audio/domain/usecase/get_audio_files.dart';
import 'package:meta/meta.dart';

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  AudioBloc(this.useCase) : super(AudioInitial()) {
    on<LoadAudioEvent>(_onloadDownloadEvents);
  }

  final GetAudioFiles useCase;
  Future<void> _onloadDownloadEvents(
    LoadAudioEvent event,
    Emitter<AudioState> emit,
  ) async {
    emit(AudioLoading());
    try {
      final audio = await useCase();
      emit(AudioSuccess(files: audio));
    } catch (e) {
      emit(AudioFailure(message: e.toString()));
    }
  }
}
