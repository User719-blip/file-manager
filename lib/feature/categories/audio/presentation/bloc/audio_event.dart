part of 'audio_bloc.dart';

@immutable
sealed class AudioEvent {}

class LoadAudioEvent extends AudioEvent {
  LoadAudioEvent();
}