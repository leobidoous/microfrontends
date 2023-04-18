import 'package:core/core.dart';

import '../../domain/repositories/i_home_repository.dart';
import '../../domain/usecases/i_home_usecase.dart';

class HomeUsecase extends IHomeUsecase {
  final IHomeRepository repository;

  HomeUsecase({required this.repository});

  @override
  Future<Either<Exception, Unit>> fecthNearbyShoppping() {
    return repository.fecthNearbyShoppping();
  }
}
