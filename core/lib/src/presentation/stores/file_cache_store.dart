import 'dart:io';

import '../../../core.dart';

class FileCacheStore extends NotifierStore<Exception, File> {
  FileCacheStore() : super(File(''));

  Future<void> createFile({
    required String filename,
    required String folder,
    required String b64,
    String extension = 'jpg',
  }) async {
    setLoading(true);
    final response = await FileCache.createFile(
      filename: filename,
      folder: folder,
      b64: b64,
      extension: extension,
    );
    response.fold(setError, update);
    setLoading(false);
  }
}
