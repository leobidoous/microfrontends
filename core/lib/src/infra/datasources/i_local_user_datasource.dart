import '../../domain/entities/session_entity.dart';
import '../../domain/entities/user_preferences_entity.dart';
import '../../domain/interfaces/either.dart';

abstract class ILocalUserDatasource {
  Future<Either<Exception, Unit>> setSession({required SessionEntity session});
  Future<Either<Exception, SessionEntity>> getSession();
  Future<Either<Exception, Unit>> removeSession();
  Future<Either<Exception, Unit>> setUserPreferences({
    required UserPreferencesEntity preferences,
  });
  Future<Either<Exception, UserPreferencesEntity>> getUserPreferences({
    required String userId,
  });
  Future<Either<Exception, Unit>> removePreferencesByUser({
    required String userId,
  });
}
