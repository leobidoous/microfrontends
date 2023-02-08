import 'package:flutter/services.dart';

class CustomClipboard {
  static Future<void> copyFrom(String value) async {
    return Clipboard.setData(ClipboardData(text: value));
  }
}
