import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';

class FileCache {
  static Future<Either<Exception, File>> createFile({
    required String filename,
    required String folder,
    required String b64,
    String extension = 'jpg',
  }) async {
    try {
      final data = base64.decode(b64);
      Directory tempDir = await getTemporaryDirectory();
      await tempDir.create(recursive: true);
      String tempPath = tempDir.path;
      final file = File('$tempPath/$folder/$filename.$extension');
      await file.create(recursive: true);
      await file.writeAsBytes(data);
      // throw Exception('erar ' * 180);
      return Right(file);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
