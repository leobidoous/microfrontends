import 'dart:developer';

import '../../../../core.dart';

class DefaultInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // final _client = Modular.get<DioClient>();
    // _client.client.lock();
    // await Future.delayed(const Duration(seconds: 2));
    // _client.client.unlock();
    log('REQUEST[${options.method}] => PATH: ${options.path}');

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    log(
      'RESPONSE[${response.statusCode}] => '
      'PATH: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    log(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    return super.onError(err, handler);
  }
}
