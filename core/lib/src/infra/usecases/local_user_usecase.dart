import '../../domain/entities/session_entity.dart';
import '../../domain/entities/user_preferences_entity.dart';
import '../../domain/interfaces/either.dart';
import '../../domain/repositories/i_local_user_repository.dart';
import '../../domain/usecases/i_local_user_usecase.dart';

class LocalUserUsecase extends ILocalUserUsecase {
  final ILocalUserRepository repository;

  LocalUserUsecase({required this.repository});

  @override
  Future<Either<Exception, SessionEntity>> getSession() {
    return repository.getSession();
  }

  @override
  Future<Either<Exception, Unit>> removeSession() {
    return repository.removeSession();
  }

  @override
  Future<Either<Exception, Unit>> setSession({required SessionEntity session}) {
    return repository.setSession(session: session);
  }

  @override
  Future<Either<Exception, UserPreferencesEntity>> getUserPreferences({
    required String userId,
  }) {
    return repository.getUserPreferences(userId: userId);
  }

  @override
  Future<Either<Exception, Unit>> removePreferencesByUser({
    required String userId,
  }) {
    return repository.removePreferencesByUser(userId: userId);
  }

  @override
  Future<Either<Exception, Unit>> setUserPreferences({
    required UserPreferencesEntity preferences,
  }) {
    return repository.setUserPreferences(preferences: preferences);
  }
}
