import '../../domain/entities/customer_entity.dart';
import '../../domain/entities/firebase_token_result_entity.dart';
import '../../domain/interfaces/either.dart';
import '../../domain/repositories/i_user_repository.dart';
import '../../domain/usecases/i_user_usecase.dart';

class UserUsecase extends IUserUsecase {
  final IUserRepository repository;

  UserUsecase({required this.repository});

  @override
  Future<Either<Exception, CustomerEntity>> getUserById({required String id}) {
    return repository.getUserById(id: id);
  }

  @override
  Future<Either<Exception, FirebaseTokenResultEntity>> getFirebaseUser({
    bool forceRefresh = false,
  }) {
    return repository.getFirebaseUser(forceRefresh: forceRefresh);
  }
}
