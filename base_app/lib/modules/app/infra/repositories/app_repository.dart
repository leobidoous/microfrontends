import 'package:core/core.dart';

import '../../domain/repositories/i_app_repository.dart';
import '../datasources/i_app_datasource.dart';

class AppRepository extends IAppRepository {
  final IAppDatasource datasource;

  AppRepository({required this.datasource});

  @override
  Future<Either<Exception, PackageInfoEntity>> getAppVersion({
    required String product,
    required String platform,
  }) {
    return datasource.getAppVersion(product: product, platform: platform);
  }
}
