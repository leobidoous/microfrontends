import '../../../core.dart';
import '../../data/datasources/download_file_datasource.dart';
import '../../infra/services/download_file_service.dart';
import '../usecases/download_file_usecase.dart';

abstract class IDownloadFileUsecaseFactory {
  Future<Either<HttpDriverResponse, HttpDriverResponse>> call({
    required TokenEntity token,
    required String filePath,
  });
}

class DownloadFileUsecaseFactory extends IDownloadFileUsecaseFactory {
  @override
  Future<Either<HttpDriverResponse, HttpDriverResponse>> call({
    required TokenEntity token,
    required String filePath,
  }) {
    final dio = Dio();
    final dioClientDriver = DioClientDriver(client: dio);
    final downloadFileDatasource =
        DownloadFileDatasource(driver: dioClientDriver);
    final downloadFileService =
        DownloadFileService(datasource: downloadFileDatasource);
    final downloadImageUsecase =
        DownloadImageUsecase(service: downloadFileService);
    return downloadImageUsecase(token: token, filePath: filePath);
  }
}
