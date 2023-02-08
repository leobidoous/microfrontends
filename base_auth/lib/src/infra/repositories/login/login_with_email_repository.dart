import 'package:core/core.dart';

import '../../../domain/entities/login_email_entity.dart';
import '../../../domain/repositories/login/login_with_email_repository.dart';
import '../../datasources/login/login_with_email_datasource.dart';

class LoginWithEmailRepository extends ILoginWithEmailRepository {
  final ILoginWithEmailDatasource datasource;

  LoginWithEmailRepository({required this.datasource});

  @override
  Future<Either<Exception, TokenEntity>> call({
    required LoginEmailEntity data,
  }) {
    return datasource(data: data);
  }
}
