import 'dart:io';
import 'package:file_manager/feature/categories/audio/data/model/audio_model.dart';
import 'package:path/path.dart' as p;

class AudioLocalDataSource {
  Future<List<AudioModel>> getAudioFiles() async {
    final dir = Directory('/storage/emulated/0/'); // Or anywhere you store audio
    final allFiles = await dir.list(recursive: true).toList();

    final audioExtensions = ['.mp3', '.wav', '.m4a', '.aac', '.flac'];

    final audioFiles = allFiles.whereType<File>().where((file) {
      final extension = p.extension(file.path).toLowerCase();
      return audioExtensions.contains(extension);
    }).toList();

    return audioFiles.map((file) => AudioModel.fromFile(file)).toList();
  }
}
