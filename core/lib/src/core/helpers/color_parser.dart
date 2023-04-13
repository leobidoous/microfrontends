import 'package:flutter/material.dart';
import 'errors/print_exception.dart';

Color? stringToColor(String colorStr) {
  try {
    return Color(int.parse('FF${colorStr.substring(1)}', radix: 16));
  } catch (e, s) {
    printException(exception: e, stackTrace: s);
    return null;
  }
}

String? colorToString(Color color) {
  try {
    return '#${color.value.toRadixString(16)}'
        .toUpperCase()
        .replaceFirst('FF', '');
  } catch (e, s) {
    printException(exception: e, stackTrace: s);
    return null;
  }
}
