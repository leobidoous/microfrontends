import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class PaymentVoucherController extends GenController {
  PaymentVoucherController() : super({});

  final screenshotController = ScreenshotController();
  bool showButton = false;

  void takeScreenShoot() async {
    showButton = false;
    screenshotController.capture().then((image) async {
      await screenshotController
          .capture(delay: const Duration(milliseconds: 10))
          .then((image) async {
        if (image != null) {
          final directory = await getApplicationDocumentsDirectory();
          final imagePath = await File('${directory.path}/image.png').create();
          await imagePath.writeAsBytes(image);

          /// Share Plugin
          await Share.shareFiles([imagePath.path]);
          showButton = true;
          Future.delayed(const Duration(seconds: 2), () => showButton = false);
        }
      });
    }).catchError((onError) {
      debugPrint(onError);
    });
  }
}
