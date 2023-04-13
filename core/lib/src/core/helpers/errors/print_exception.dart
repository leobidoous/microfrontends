import 'package:flutter/material.dart';

void printException({
  required dynamic exception,
  StackTrace? stackTrace,
}) {
  String exceptionType = '';

  switch (exception.runtimeType) {
    case Exception:
      exceptionType = 'EXCEPTION:';
      break;
    case Error:
      exceptionType = 'ERROR:';
      break;
    default:
      exceptionType = 'UNKNOW:';
  }
  debugPrint('---------------------------------');
  debugPrint(
    '- $exceptionType $exception \n- '
    '${stackTrace ?? 'stackTrace not released'}',
  );
  debugPrint('---------------------------------');
}
