import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../../../core.dart';

class DefaultInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String queryParameters = '';
    options.queryParameters.forEach((key, value) {
      if (key != options.queryParameters.entries.last.key) {
        queryParameters += '$key=$value&';
      } else {
        queryParameters += '$key=$value';
      }
    });

    if (kDebugMode) {
      log(
        'REQUEST[${options.method}] => PATH: ${options.path}'
        '${queryParameters.isNotEmpty ? '?$queryParameters' : ''}',
      );
    }

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (kDebugMode) {
      log(
        'RESPONSE[${response.statusCode}] => '
        'PATH: ${response.requestOptions.path}',
      );
    }
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (kDebugMode) {
      log(
        'ERROR[${err.response?.statusCode}] => '
        'PATH: ${err.requestOptions.path}',
      );
    }
    return super.onError(err, handler);
  }
}
