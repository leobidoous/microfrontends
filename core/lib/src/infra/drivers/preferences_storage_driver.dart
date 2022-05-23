import '../../../core.dart';

abstract class IPreferencesStorageDriver {
  Future<Either<Exception, Unit>> saveStringByKey({
    required String key,
    required String value,
  });
  Future<Either<Exception, Unit>> saveStringListByKey({
    required String key,
    required List<String> value,
  });
  Future<Either<Exception, Unit>> removeStringByKey({
    required String key,
  });
  Future<Either<Exception, String>> getStringByKey({
    required String key,
  });
  Future<Either<Exception, List<String>>> getStringListByKey({
    required String key,
  });
}
