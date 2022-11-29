import '../../../core.dart';

abstract class IDownloadFileDatasource {
  Future<Either<HttpDriverResponse, HttpDriverResponse>> downloadFile(
    TokenEntity token,
    String path,
  );
}
