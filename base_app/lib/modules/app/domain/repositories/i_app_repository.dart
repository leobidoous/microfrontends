import 'package:core/core.dart';

abstract class IAppRepository {
  Future<Either<Exception, PackageInfoEntity>> getAppVersion({
    required String product,
    required String platform,
  });
}
