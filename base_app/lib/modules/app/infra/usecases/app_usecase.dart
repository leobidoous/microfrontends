import 'package:core/core.dart';

import '../../domain/repositories/i_app_repository.dart';
import '../../domain/usecases/i_app_usecase.dart';

class AppUsecase extends IAppUsecase {
  final IAppRepository repository;

  AppUsecase({required this.repository});

  @override
  Future<Either<Exception, PackageInfoEntity>> getAppVersion({
    required String product,
    required String platform,
  }) {
    return repository.getAppVersion(product: product, platform: platform);
  }
}
