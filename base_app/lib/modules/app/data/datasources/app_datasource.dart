import 'package:core/core.dart';

import '../../infra/datasources/i_app_datasource.dart';

class AppDatasource extends IAppDatasource {
  final FirebaseStorageDriver storageDriver;

  AppDatasource({required this.storageDriver});

  @override
  Future<Either<Exception, PackageInfoEntity>> getAppVersion({
    required String product,
    required String platform,
  }) async {
    final response =
        await storageDriver.docGet(collection: 'appVersion', doc: product);
    return response.fold((l) => Left(l), (r) {
      try {
        return Right(PackageInfoModel.fromMap(r.data()?[platform] ?? {}));
      } catch (e) {
        return Left(Exception(e));
      }
    });
  }
}
