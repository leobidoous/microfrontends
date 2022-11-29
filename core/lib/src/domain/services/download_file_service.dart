import '../../../core.dart';

abstract class IDownloadFileService {
  Future<Either<HttpDriverResponse, HttpDriverResponse>> call(
    TokenEntity token,
    String path,
  );
}
