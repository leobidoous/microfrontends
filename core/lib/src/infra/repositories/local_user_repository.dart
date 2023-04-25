import '../../domain/entities/session_entity.dart';
import '../../domain/entities/user_preferences_entity.dart';
import '../../domain/interfaces/either.dart';
import '../../domain/repositories/i_local_user_repository.dart';
import '../datasources/i_local_user_datasource.dart';

class LocalUserRepository extends ILocalUserRepository {
  final ILocalUserDatasource datasource;

  LocalUserRepository({required this.datasource});

  @override
  Future<Either<Exception, SessionEntity>> getSession() {
    return datasource.getSession();
  }

  @override
  Future<Either<Exception, Unit>> removeSession() {
    return datasource.removeSession();
  }

  @override
  Future<Either<Exception, Unit>> setSession({required SessionEntity session}) {
    return datasource.setSession(session: session);
  }

  @override
  Future<Either<Exception, UserPreferencesEntity>> getUserPreferences({
    required String userId,
  }) {
    return datasource.getUserPreferences(userId: userId);
  }

  @override
  Future<Either<Exception, Unit>> removePreferencesByUser({
    required String userId,
  }) {
    return datasource.removePreferencesByUser(userId: userId);
  }

  @override
  Future<Either<Exception, Unit>> setUserPreferences({
    required UserPreferencesEntity preferences,
  }) {
    return datasource.setUserPreferences(preferences: preferences);
  }
}
