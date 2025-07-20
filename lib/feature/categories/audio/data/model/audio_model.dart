import 'dart:io';

import 'package:file_manager/feature/categories/audio/domain/entity/audio_entity.dart';

class AudioModel extends AudioEntity {
  AudioModel({required super.title, required super.path, required super.size});

  factory AudioModel.fromFile(File file) {
    final fileName = file.path.split('/').last;
    final size = file.lengthSync();

    return AudioModel(
      title: fileName,
      path: file.path,
      size: size,
    );
  }
}
