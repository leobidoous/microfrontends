import 'dart:convert' show jsonDecode;

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart' show rootBundle;

class LoadJson {
  static Future<Either<Exception, Map<String, dynamic>>> fromAsset(
    String path, {
    Map<String, dynamic> Function(dynamic data)? saveInLocalDatabase,
  }) async {
    try {
      final data = await rootBundle.loadString(path);
      var result = jsonDecode(data);

      if (saveInLocalDatabase != null) {
        return Right(saveInLocalDatabase(result));
      }

      return Right(result);
    } catch (e) {
      return Left(Exception('LoadMock.fromAsset($path): $e'));
    }
  }
}
