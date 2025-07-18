part of 'download_bloc.dart';

@immutable
sealed class DownloadEvent {}


class LoadDownloadEvent extends DownloadEvent {
  LoadDownloadEvent();
}