
import 'package:dartz/dartz.dart';

import '../../../domain/repositories/auth/logout_repository.dart';
import '../../datasources/auth/logout_datasource.dart';

class LogoutRepository extends ILogoutRepository {
  final ILogoutDatasource datasource;

  LogoutRepository({required this.datasource});

  @override
  Future<Either<Exception, Unit>> call() {
    return datasource();
  }
}
