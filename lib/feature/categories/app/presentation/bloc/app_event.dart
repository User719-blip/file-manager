part of 'app_bloc.dart';

@immutable
sealed class AppEvent {}


class LoadAppEvent extends AppEvent {
  LoadAppEvent();
}