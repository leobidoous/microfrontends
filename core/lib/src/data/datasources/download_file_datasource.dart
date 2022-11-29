import '../../../core.dart';
import '../../infra/datasources/download_file_datasource.dart';

class DownloadFileDatasource extends IDownloadFileDatasource {
  final IHttpDriver driver;

  DownloadFileDatasource({required this.driver});

  @override
  Future<Either<HttpDriverResponse, HttpDriverResponse>> downloadFile(
    TokenEntity token,
    String path,
  ) {
    HttpDriverOptions options = HttpDriverOptions(
      accessToken: token.accessToken,
      accessTokenType: token.tokenType,
      extraHeaders: {'x-ms-version': '2021-08-06'},
    );
    return driver.getFile(
      path,
      options: options,
    );
  }
}
