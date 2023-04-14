import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

class WarningNewVersionController extends GenController<Exception, Unit> {
  late final String url;

  WarningNewVersionController() : super(unit) {
    if (Platform.isIOS) {
      url =
          'https://apps.apple.com/br/app/gen-pague-f%C3%A1cil-e-online/id6443802221';
    } else {
      url = 'https://play.google.com/store/apps/details?id=br.com.gen';
    }
  }

  Future<void> goToStore() async {
    await launchUrl(Uri.parse(url)).catchError((onError) {
      debugPrint('goToStore error: $onError');
      return false;
    });
  }
}
