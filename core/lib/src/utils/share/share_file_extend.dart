import 'package:share_extend/share_extend.dart';

import '../../../core.dart';

abstract class IShareExtend {
  Future<Either<Exception, Unit>> shareImageFromLocalStorage({
    required String completPath,
    String? sharePanelTitle,
    required String subject,
    required String extraText,
  });

  Future<Either<Exception, Unit>> sharePdfFromLocalStorage({
    required String completPath,
    String? sharePanelTitle,
    required String subject,
    required String extraText,
  });
}

class ShareFileExtend with IShareExtend {
  ShareFileExtend._();
  static final ShareFileExtend instance = ShareFileExtend._();

  @override
  Future<Either<Exception, Unit>> shareImageFromLocalStorage({
    required String completPath,
    String? sharePanelTitle,
    required String subject,
    required String extraText,
  }) async {
    try {
      await ShareExtend.share(
        completPath,
        'image',
        sharePanelTitle: sharePanelTitle,
        subject: subject,
        extraText: extraText,
      );
      return const Right(unit);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Unit>> sharePdfFromLocalStorage({
    required String completPath,
    String? sharePanelTitle,
    required String subject,
    required String extraText,
  }) async {
    try {
      await ShareExtend.share(
        completPath,
        'file',
        sharePanelTitle: sharePanelTitle,
        subject: subject,
        extraText: extraText,
      );
      return const Right(unit);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
