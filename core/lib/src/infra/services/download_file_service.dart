import '../../../core.dart';
import '../../domain/services/download_file_service.dart';
import '../datasources/download_file_datasource.dart';

class DownloadFileService implements IDownloadFileService {
  final IDownloadFileDatasource datasource;

  DownloadFileService({required this.datasource});

  @override
  Future<Either<HttpDriverResponse, HttpDriverResponse>> call(
    TokenEntity token,
    String path,
  ) {
    return datasource.downloadFile(
      token,
      path,
    );
  }
}
