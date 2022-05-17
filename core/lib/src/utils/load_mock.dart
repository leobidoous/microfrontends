import 'dart:convert';

import 'package:flutter/services.dart';

class LoadMock {
  static Future<Map<String, dynamic>> fromAsset(String path,
      {Map<String, dynamic> Function(dynamic data)?
          saveInLocalDatabase}) async {
    final data = await rootBundle.loadString('assets/mocks/$path');
    var _result = jsonDecode(data);

    if (saveInLocalDatabase != null) {
      return saveInLocalDatabase(_result);
    }

    return _result;
  }
}
