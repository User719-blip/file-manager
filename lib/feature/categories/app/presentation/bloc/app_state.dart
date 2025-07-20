part of 'app_bloc.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}


final class AppLoading extends AppState {}

final class AppSuccess extends AppState {
  
  final List<AppEntity> files;

  AppSuccess({required this.files});
}

final class AppFailure extends AppState {
  final String? message;

  AppFailure({required this.message});
}
