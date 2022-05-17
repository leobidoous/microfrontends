import 'package:core/core.dart';

import '../../entities/login/login_with_email_entity.dart';

abstract class ILoginWithEmailRepository {
  Future<Either<Exception, Object>> call({required LoginWithEmailEntity login});

}