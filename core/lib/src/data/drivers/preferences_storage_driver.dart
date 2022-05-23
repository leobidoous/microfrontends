import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../infra/drivers/preferences_storage_driver.dart';

class PreferencesStorageDriver extends IPreferencesStorageDriver {
  PreferencesStorageDriver();

  @override
  Future<Either<Exception, Unit>> removeStringByKey({
    required String key,
  }) async {
    try {
      final instance =await  SharedPreferences.getInstance();
      final removed = await instance.remove(key);
      if (removed == false) {
        return Left(Exception('Erro ao remover $key'));
      }
      return const Right(unit);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Unit>> saveStringByKey({
    required String key,
    required String value,
  }) async {
    try {
      final instance =await  SharedPreferences.getInstance();
      final saved = await instance.setString(key, value);
      if (saved == false) {
        return Left(Exception('Erro ao salvar $key'));
      }
      return const Right(unit);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, String>> getStringByKey({
    required String key,
  }) async {
    try {
      final instance =await  SharedPreferences.getInstance();
      final response = instance.getString(key);
      if (response == null) {
        return Left(Exception('Erro ao obter $key'));
      }
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<String>>> getStringListByKey({
    required String key,
  }) async {
    try {
      final instance =await  SharedPreferences.getInstance();
      final response = instance.getStringList(key);
      if (response == null) {
        return Left(Exception('Erro ao obter $key'));
      }
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Unit>> saveStringListByKey({
    required String key,
    required List<String> value,
  }) async {
    try {
      final instance =await  SharedPreferences.getInstance();
      final saved = await instance.setStringList(key, value);
      if (saved == false) {
        return Left(Exception('Erro ao salvar $key'));
      }
      return const Right(unit);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
