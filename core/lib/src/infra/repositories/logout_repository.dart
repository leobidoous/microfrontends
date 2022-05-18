import '../../../core.dart';
import '../../domain/repositories/logout_repository.dart';

class LogoutRepository extends ILogoutRepository {
  final ILogoutDatasource datasource;

  LogoutRepository({required this.datasource});

  @override
  Future<Either<Exception, Unit>> call() {
    return datasource();
  }
}
