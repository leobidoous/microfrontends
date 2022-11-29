import '../../../core.dart';
import '../../utils/share/share_file_extend.dart';

abstract class IShareFileUsecase {
  Future<Either<Exception, Unit>> shareImageFromLocalStorage({
    required String path,
    required String text,
    required String subject,
  });
  Future<Either<Exception, Unit>> sharePdfFromLocalStorage({
    required String path,
    required String text,
    required String subject,
  });
}

class ShareFileUsecase extends IShareFileUsecase {
  final IShareExtend share;

  ShareFileUsecase(
    this.share,
  );

  @override
  Future<Either<Exception, Unit>> shareImageFromLocalStorage({
    required String path,
    required String text,
    required String subject,
  }) async {
    await share.shareImageFromLocalStorage(
      completPath: path,
      subject: subject,
      extraText: text,
    );
    return const Right(unit);
  }

  @override
  Future<Either<Exception, Unit>> sharePdfFromLocalStorage({
    required String path,
    required String text,
    required String subject,
  }) async {
    await share.sharePdfFromLocalStorage(
      completPath: path,
      subject: subject,
      extraText: text,
    );
    return const Right(unit);
  }
}
