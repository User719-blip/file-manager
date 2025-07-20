import 'package:bloc/bloc.dart';
import 'package:file_manager/feature/categories/app/domain/entity/app_entity.dart';
import 'package:file_manager/feature/categories/app/domain/usecase/get_app_files.dart';
import 'package:meta/meta.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(this.useCase) : super(AppInitial()) {
    on<LoadAppEvent>(_onLoadingApp as EventHandler<LoadAppEvent, AppState>);
  }

  final GetInstalledApps useCase;

  Future<void> _onLoadingApp(LoadAppEvent event, Emitter<AppState> emit) async {
    emit(AppLoading());
    try {
      final app = await useCase();
      emit(AppSuccess(files: app));
    } catch (e) {
      emit(AppFailure(message: e.toString()));
    }
  }
}
