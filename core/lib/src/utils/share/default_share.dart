import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core.dart';

class DefaultShare {
  static Future<Either<Exception, Unit>> image({
    required BuildContext context,
    required List<String> files,
    String? text,
    String? subject,
  }) async {
    final box = context.findRenderObject() as RenderBox?;
    try {
      // ignore: deprecated_member_use
      await Share.shareFiles(
        files,
        text: text,
        subject: subject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
      return const Right(unit);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  static Future<void> text(
    BuildContext context, {
    required String text,
    String? subject,
  }) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
      text,
      subject: subject,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}
