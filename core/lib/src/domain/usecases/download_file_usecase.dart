// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../core.dart';
import '../services/download_file_service.dart';

abstract class IDownloadImageUsecase {
  Future<Either<HttpDriverResponse, HttpDriverResponse>> call({
    required TokenEntity token,
    required String filePath,
  });
}

class DownloadImageUsecase extends IDownloadImageUsecase {
  final IDownloadFileService service;

  DownloadImageUsecase({
    required this.service,
  });

  @override
  Future<Either<HttpDriverResponse, HttpDriverResponse>> call({
    required TokenEntity token,
    required String filePath,
  }) async {
    return await service(token, filePath);
  }
}
