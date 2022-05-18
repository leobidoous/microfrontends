import 'package:shared_preferences/shared_preferences.dart';

import '../../../core.dart';
import '../../constants/mapping_preferences.dart';

class LoggedUserDatasource extends ILoggedUserDatasource {
  final LocalStorageDriver storageDriver;

  LoggedUserDatasource({required this.storageDriver});

  @override
  Future<Either<Exception, LoggedUserEntity>> getLoggedUser() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      final String? response = _prefs.getString(UserConstants.loggedUser);
      if (response == null) {
        return Left(Exception('Nenhum usuário autenticado'));
      }
      return Right(LoggedUserModel.fromJson(response).toEntity());
    } catch (e) {
      return Left(Exception('LoggedUserDatasource().getLoggedUser: $e'));
    }
  }

  @override
  Future<Either<Exception, Unit>> saveLoggedUser({
    required LoggedUserEntity user,
  }) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      await _prefs.setString(
        UserConstants.loggedUser,
        LoggedUserModel.fromEntiy(user).toJson(),
      );
      return const Right(unit);
    } catch (e) {
      return Left(Exception('LoggedUserDatasource().saveLoggedUser: $e'));
    }
  }
  
  @override
  Future<Either<Exception, Unit>> removeLoggedUser() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      await _prefs.remove(UserConstants.loggedUser);
      return const Right(unit);
    } catch (e) {
      return Left(Exception('LoggedUserDatasource().getLoggedUser: $e'));
    }
  }
}
