
import 'package:core/core.dart';

import '../../domain/repositories/logout_repository.dart';
import '../datasources/logout_datasource.dart';

class LogoutRepository extends ILogoutRepository {
  final ILogoutDatasource datasource;

  LogoutRepository({required this.datasource});

  @override
  Future<Either<Exception, Unit>> call() {
    return datasource();
  }
}
