import 'package:core/core.dart';

import '../../../domain/entities/login_email_entity.dart';

abstract class ILoginWithEmailDatasource {
  Future<Either<Exception, TokenEntity>> call({required LoginEmailEntity data});
}
