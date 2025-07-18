import 'dart:io';

class ClipboardManager<T> {
  static final ClipboardManager _instance = ClipboardManager._internal();

  factory ClipboardManager() => _instance as ClipboardManager<T>;

  ClipboardManager._internal();

  List<T> _copiedItems = [];
  bool _isCut = false;

  void copy(List<T> items) {
    _copiedItems = List.from(items);
    _isCut = false;
  }

  void cut(List<T> items) {
    _copiedItems = List.from(items);
    _isCut = true;
  }

  Future<void> paste(
    String targetDir, {
    required Future<String> Function(T e) getPath,
  }) async {
    for (final item in _copiedItems) {
      final originalPath = await getPath(item); // now await
      final fileName = originalPath.split('/').last;
      final newPath = '$targetDir/$fileName';

      final file = File(originalPath);
      if (await file.exists()) {
        await file.copy(newPath);
        if (_isCut) await file.delete();
      }
    }
    _copiedItems.clear();
    _isCut = false;
  }

  void clear() {
    _copiedItems.clear();
    _isCut = false;
  }

  List<T> get copiedItems => _copiedItems;
}
