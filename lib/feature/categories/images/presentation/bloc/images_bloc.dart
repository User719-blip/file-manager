import 'package:bloc/bloc.dart';
import 'package:file_manager/feature/categories/images/domain/entities/image_entities.dart';
import 'package:file_manager/feature/categories/images/domain/usecase/image_usecase.dart';
import 'package:meta/meta.dart';

part 'images_event.dart';
part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final GetImages useCase;

  ImagesBloc({required this.useCase}) : super(ImagesInitial()) {
    on<LoadImageEvents>(_onLoadImageEvent);
  }

  Future<void> _onLoadImageEvent(
    LoadImageEvents event,
    Emitter<ImagesState> emit,
  ) async {
    emit(ImageLoading());
    try {
      // Simulate fetching images
      final file = await useCase();
      emit(ImageSuccess(files: file));
    } catch (e) {
      emit(ImageFailure(message: e.toString()));
    }
  }
}
