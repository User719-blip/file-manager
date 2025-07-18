part of 'images_bloc.dart';

@immutable
sealed class ImagesState {}

final class ImagesInitial extends ImagesState {}

final class ImageLoading extends ImagesState {}

final class ImageSuccess extends ImagesState {
  
  final List<ImageEntity> files;

  ImageSuccess({required this.files});
}

final class ImageFailure extends ImagesState {
  final String? message;

  ImageFailure({required this.message});
}
