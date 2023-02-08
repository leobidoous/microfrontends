import 'package:core/core.dart';

import '../../entities/login_email_entity.dart';

abstract class ILoginWithEmailRepository {
  Future<Either<Exception, TokenEntity>> call({required LoginEmailEntity data});
}
