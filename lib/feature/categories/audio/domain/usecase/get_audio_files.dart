import 'package:file_manager/feature/categories/audio/domain/entity/audio_entity.dart';
import 'package:file_manager/feature/categories/audio/domain/repo/audio_repo.dart';

class GetAudioFiles {
  final AudioRepo audioRepo;

  GetAudioFiles({required this.audioRepo});

  Future<List<AudioEntity>> call() async {
    return await audioRepo.getAudioFiles();
  } 

}