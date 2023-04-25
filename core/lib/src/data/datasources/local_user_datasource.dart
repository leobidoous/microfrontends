import '../../core/constants/user_constants.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/entities/user_preferences_entity.dart';
import '../../domain/interfaces/either.dart';
import '../../infra/datasources/i_local_user_datasource.dart';
import '../../infra/drivers/preferences_storage_driver.dart';
import '../../infra/models/session_model.dart';
import '../../infra/models/user_preferences_model.dart';

class LocalUserDatasource extends ILocalUserDatasource {
  final IPreferencesStorageDriver prefsDriver;

  LocalUserDatasource({required this.prefsDriver});

  @override
  Future<Either<Exception, SessionEntity>> getSession() async {
    final response = await prefsDriver.getStringByKey(
      key: UserConstants.session,
    );
    return response.fold(
      (l) => Left(l),
      (r) {
        try {
          return Right(SessionModel.fromJson(r));
        } catch (e) {
          return Left(Exception('LocalUserDatasource().getSession: $e'));
        }
      },
    );
  }

  @override
  Future<Either<Exception, Unit>> setSession({
    required SessionEntity session,
  }) async {
    return prefsDriver.setStringByKey(
      key: UserConstants.session,
      value: SessionModel.fromEntity(session).toJson,
    );
  }

  @override
  Future<Either<Exception, Unit>> removeSession() async {
    return prefsDriver.removeStringByKey(key: UserConstants.session);
  }

  @override
  Future<Either<Exception, UserPreferencesEntity>> getUserPreferences({
    required String userId,
  }) async {
    final response = await prefsDriver.getStringByKey(
      key: '${UserConstants.preferences}_$userId',
    );
    return response.fold(
      (l) => Left(l),
      (r) {
        try {
          return Right(UserPreferencesModel.fromJson(r));
        } catch (e) {
          return Left(
            Exception('LocalUserDatasource().getUserPreferences: $e'),
          );
        }
      },
    );
  }

  @override
  Future<Either<Exception, Unit>> removePreferencesByUser({
    required String userId,
  }) {
    return prefsDriver.removeStringByKey(
      key: '${UserConstants.preferences}_$userId',
    );
  }

  @override
  Future<Either<Exception, Unit>> setUserPreferences({
    required UserPreferencesEntity preferences,
  }) {
    return prefsDriver.setStringByKey(
      key: '${UserConstants.preferences}_${preferences.id}',
      value: UserPreferencesModel.fromEntity(preferences).toJson,
    );
  }
}
