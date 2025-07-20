import 'package:file_manager/feature/categories/audio/domain/entity/audio_entity.dart';

abstract class AudioRepo {
  Future<List<AudioEntity>> getAudioFiles();
}