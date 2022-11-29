import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../core.dart';

/// class [ObjectScreenShot] to take screenshots
/// from widgets or components (receipts)
class ObjectScreenShot {
  /// [take] screenshot method
  static Future<void> take({
    required BuildContext context,
    required GlobalKey key,
    String filename = 'file',
    String? text,
    String? subject,
  }) async {
    final boundary =
        key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    var image = await boundary?.toImage(pixelRatio: 3);
    var byteData = await image?.toByteData(format: ImageByteFormat.png);
    var pngBytes = byteData?.buffer.asUint8List();

    Directory tempDir = await getTemporaryDirectory();
    await tempDir.create(recursive: true);
    String tempPath = tempDir.path;
    final file = File('$tempPath/$filename.png');
    await file.create(recursive: true);
    await file.writeAsBytes(pngBytes ?? []);

    await DefaultShare.image(
      context: context,
      files: [file.path],
      text: text,
      subject: subject,
    );
  }
}
