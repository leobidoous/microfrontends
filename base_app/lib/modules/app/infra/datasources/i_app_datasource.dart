import 'package:core/core.dart';

abstract class IAppDatasource {
  Future<Either<Exception, PackageInfoEntity>> getAppVersion({
    required String product,
    required String platform,
  });
}
