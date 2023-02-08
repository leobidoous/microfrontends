import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/user_constants.dart';
import '../../domain/entities/token_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../infra/datasources/local_user_datasource.dart';
import '../../infra/models/token_model.dart';
import '../../infra/models/user_model.dart';

class LocalUserDatasource extends ILocalUserDatasource {
  @override
  Future<Either<Exception, UserEntity>> getLocalUser() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final String? response = prefs.getString(UserConstants.user);
      if (response == null) {
        return Left(Exception('Nenhum usuário autenticado'));
      }
      return Right(UserModel.fromJson(response));
    } catch (e) {
      return Left(Exception('LocalUserDatasource().getUser: $e'));
    }
  }

  @override
  Future<Either<Exception, Unit>> setLocalUser({
    required UserEntity user,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(
        UserConstants.user,
        UserModel.fromEntity(user).toJson,
      );
      return const Right(unit);
    } catch (e) {
      return Left(Exception('LocalUserDatasource().setUser: $e'));
    }
  }

  @override
  Future<Either<Exception, Unit>> removeLocalUser() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await prefs.remove(UserConstants.user);
      return const Right(unit);
    } catch (e) {
      return Left(Exception('LocalUserDatasource().removeSavedUser: $e'));
    }
  }

  @override
  Future<Either<Exception, TokenEntity>> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final String? response = prefs.getString(
        UserConstants.token,
      );
      if (response == null) {
        return Left(Exception('Nenhum token encontrado'));
      }
      return Right(TokenModel.fromJson(response));
    } catch (e) {
      return Left(Exception('LocalUserDatasource().getToken: $e'));
    }
  }

  @override
  Future<Either<Exception, Unit>> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await prefs.remove(UserConstants.token);
      return const Right(unit);
    } catch (e) {
      return Left(Exception('LocalUserDatasource().removeToken: $e'));
    }
  }

  @override
  Future<Either<Exception, Unit>> setToken({required TokenEntity token}) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(
        UserConstants.token,
        TokenModel.fromEntity(token).toJson,
      );
      return const Right(unit);
    } catch (e) {
      return Left(Exception('LocalUserDatasource().setToken: $e'));
    }
  }
}
