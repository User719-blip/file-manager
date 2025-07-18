part of 'images_bloc.dart';

@immutable
sealed class ImagesEvent {}

class LoadImageEvents extends ImagesEvent {
  LoadImageEvents();
}