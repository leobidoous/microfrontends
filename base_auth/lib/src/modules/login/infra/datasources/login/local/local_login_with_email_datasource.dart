import 'package:core/core.dart';

import '../../../../domain/entities/login/login_with_email_entity.dart';

abstract class ILocalLoginWithEmailDatasource {
  Future<Either<Exception, Object>> call({
    required LoginWithEmailEntity login,
  });
}
