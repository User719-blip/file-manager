part of 'download_bloc.dart';

@immutable
sealed class DownloadState {}

final class DownloadInitial extends DownloadState {}

final class DownloadLoading extends DownloadState {}

final class DownloadSuccess extends DownloadState {
  
  final List<DownloadEntities> files;

  DownloadSuccess({required this.files});
}

final class DownloadFailure extends DownloadState {
  final String? message;

  DownloadFailure({required this.message});
}