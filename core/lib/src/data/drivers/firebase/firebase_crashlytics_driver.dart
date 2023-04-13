import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/firebase/i_firebase_crashlytics_driver.dart';

class FirebaseCrashlyticsDriver extends IFirebaseCrashlyticsDriver {
  final FirebaseCrashlytics instance;

  FirebaseCrashlyticsDriver({required this.instance});

  @override
  Future<Either<Exception, Unit>> init() async {
    try {
      await instance.setCrashlyticsCollectionEnabled(true);
      FlutterError.onError = instance.recordFlutterError;
      debugPrint('FirebaseCrashlyticsDriver iniciado com sucesso.');
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('Erro ao inicializar FirebaseCrashlyticsDriver.');
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
      return Right(unit);
    } catch (exception) {
      return Left(Exception(exception));
    }
  }
}
