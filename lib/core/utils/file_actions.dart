import 'dart:io';
import 'package:file_manager/feature/categories/download/domain/entities/download_entities.dart';
import 'package:file_manager/feature/categories/images/domain/entities/image_entities.dart';
import 'package:photo_manager/photo_manager.dart';

class FileActions {
  static Future<void> deleteFiles(List<DownloadEntities> files) async {
    for (var file in files) {
      try {
        final f = File(file.path);
        if (await f.exists()) {
          await f.delete();
        }
      } catch (e) {
        // Handle individual file error
      }
    }
  }
    
  static Future<void> deleteImages(List<ImageEntity> images) async {
  for (final img in images) {
    await PhotoManager.editor.deleteWithIds([img.asset.id]);
  }
}


  static Future<void> copyFile(String sourcePath, String destinationPath) async {
    final sourceFile = File(sourcePath);
    if (await sourceFile.exists()) {
      await sourceFile.copy(destinationPath);
    }
  }

  static Future<void> moveFile(String sourcePath, String destinationPath) async {
    final sourceFile = File(sourcePath);
    if (await sourceFile.exists()) {
      await sourceFile.rename(destinationPath);
    }
  }
}
