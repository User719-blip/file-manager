import 'package:file_manager/feature/categories/audio/data/datasource/audio_datasource.dart';
import 'package:file_manager/feature/categories/audio/domain/entity/audio_entity.dart';
import 'package:file_manager/feature/categories/audio/domain/repo/audio_repo.dart';

class AudioRepoImpl implements AudioRepo {
  final AudioLocalDataSource localDataSource;

  AudioRepoImpl({required this.localDataSource});

  @override
  Future<List<AudioEntity>> getAudioFiles() async {
    return await localDataSource.getAudioFiles();
  }
}