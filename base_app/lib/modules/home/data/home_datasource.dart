import 'package:core/core.dart';

import '../infra/datasource/i_home_datasource.dart';

class HomeDatasource extends IHomeDatasource {
  HomeDatasource({
    required this.client,
    required this.baseUrl,
    required this.locationService,
    required this.permissionService,
  });

  final String baseUrl;
  final IHttpDriver client;
  final ILocationService locationService;
  final IPermissionService permissionService;

  @override
  Future<Either<Exception, Unit>> fecthNearbyShoppping() {
    throw UnimplementedError();
  }
}
