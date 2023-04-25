import 'package:core/core.dart';

abstract class IAppUsecase {
  Future<Either<Exception, PackageInfoEntity>> getAppVersion({
    required String product,
    required String platform,
  });
}
