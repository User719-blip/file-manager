part of 'audio_bloc.dart';

@immutable
sealed class AudioState {}

final class AudioInitial extends AudioState {}

final class AudioLoading extends AudioState {}

final class AudioSuccess extends AudioState {
  
  final List<AudioEntity> files;

  AudioSuccess({required this.files});
}

final class AudioFailure extends AudioState {
  final String? message;

  AudioFailure({required this.message});
}
