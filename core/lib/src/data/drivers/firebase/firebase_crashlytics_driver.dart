import 'package:dartz/dartz.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show FlutterError;

import '../../../infra/drivers/firebase/firebase_crashlytics_driver.dart';

class FirebaseCrashlyticsDriver extends IFirebaseCrashlyticsDriver {
  final FirebaseCrashlytics instance;

  FirebaseCrashlyticsDriver({required this.instance});

  @override
  Future<Either<Exception, Unit>> init() async {
    try {
      await instance.setCrashlyticsCollectionEnabled(true);
      FlutterError.onError = instance.recordFlutterError;
      return const Right(unit);
    } catch (exception, stackTrace) {
      return setError(exception: exception, stackTrace: stackTrace);
    }
  }

  @override
  Future<Either<Exception, Unit>> setError({
    required exception,
    StackTrace? stackTrace,
  }) async {
    try {
      await instance.recordError(exception, stackTrace);
      return const Right(unit);
    } catch (exception) {
      return Left(Exception(exception));
    }
  }
}
