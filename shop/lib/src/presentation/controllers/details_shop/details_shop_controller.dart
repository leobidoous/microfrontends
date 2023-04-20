import 'dart:io';

import 'package:core/core.dart' hide DateFormat;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';

class DetailsShopController extends GenController<Exception, void> {
  DetailsShopController() : super([]);

  final screenshotController = ScreenshotController();
  String hour = '';
  String day = '';

  void setCurrentDateTime() {
    hour = DateFormat('HH:mm').format(DateTime.now());
    day = DateFormat('EEEE').format(DateTime.now()).toLowerCase();
  }

  bool verifyIsOpen(String openHour, String closeHour) {
    var dtCurrentHour = DateFormat('HH:mm').parse(hour);
    var dtOpenHour = openHour != ''
        ? DateFormat('HH:mm').parse(openHour)
        : DateFormat('HH:mm').parse('00:00');
    var dtCloseHour = closeHour != ''
        ? DateFormat('HH:mm').parse(closeHour)
        : DateFormat('HH:mm').parse('00:00');

    if (dtCurrentHour.compareTo(dtOpenHour) > 0 &&
        dtCurrentHour.compareTo(dtCloseHour) < 0) {
      return true;
    } else {
      return false;
    }
  }

  void takeScreenShoot(Widget widget, String message) async {
    await screenshotController
        .captureFromWidget(widget, delay: const Duration(milliseconds: 10))
        .then((image) async {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/image.png').create();
      await imagePath.writeAsBytes(image);

      /// Share Plugin
      //TODO: await Share.shareFiles([imagePath.path], text: message);
    }).catchError((onError) {
      debugPrint(onError);
    });
  }
}
