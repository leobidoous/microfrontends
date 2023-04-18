import 'package:core/core.dart';

import '../../domain/repositories/i_home_repository.dart';
import '../datasource/i_home_datasource.dart';

class HomeRepository extends IHomeRepository {
  final IHomeDatasource datasource;

  HomeRepository({required this.datasource});

  @override
  Future<Either<Exception, Unit>> fecthNearbyShoppping() {
    return datasource.fecthNearbyShoppping();
  }
}
