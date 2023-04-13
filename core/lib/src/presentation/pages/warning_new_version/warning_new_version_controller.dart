import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class WarningNewVersionController {
  late final String url;

  WarningNewVersionController() {
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
