import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/helpers/errors/print_exception.dart';
import '../../domain/interfaces/either.dart';
import '../../infra/drivers/i_http_driver.dart';

class DioClientDriver extends IHttpDriver with Disposable {
  final Dio client;

  DioClientDriver({required this.client});

  HttpDriverResponse _responseError(DioError e, {StackTrace? s}) {
    late String statusMessage;
    final String data = json.encode(e.response?.data);

    switch (e.response?.statusCode) {
      case 400:
        statusMessage = '${e.message}\n';
        try {
          (e.response?.data as Map?)?.forEach((key, value) {
            statusMessage += '$key: $value';
            if (key != (e.response?.data as Map?)?.keys.last) {
              statusMessage += '\n';
            }
          });
        } catch (err, s) {
          printException(exception: err, stackTrace: s);
          statusMessage = '${e.message}\n$data';
        }

        break;
      default:
        statusMessage = '${e.message}\n$data';
        break;
    }

    printException(exception: e, stackTrace: s);

    return HttpDriverResponse(
      data: data,
      statusCode: e.response?.statusCode,
      statusMessage: statusMessage,
    );
  }

  @override
  Future<Either<HttpDriverResponse, HttpDriverResponse>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
  }) async {
    try {
      final response = await client.delete(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            if (options != null)
              'Authorization':
                  '${options.accessTokenType} ${options.accessToken}',
            ...?options?.extraHeaders,
          },
        ),
      );
      return Right(
        HttpDriverResponse(
          data: response.data,
          statusCode: response.statusCode,
          statusMessage: response.statusMessage,
        ),
      );
    } on DioError catch (e, s) {
      return Left(_responseError(e, s: s));
    }
  }

  @override
  Future<Either<HttpDriverResponse, HttpDriverResponse>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await client.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            if (options != null)
              'Authorization':
                  '${options.accessTokenType} ${options.accessToken}',
            ...?options?.extraHeaders,
          },
        ),
      );
      return Right(
        HttpDriverResponse(
          data: response.data,
          statusCode: response.statusCode,
          statusMessage: response.statusMessage,
        ),
      );
    } on DioError catch (e, s) {
      return Left(_responseError(e, s: s));
    }
  }

  @override
  Future<Either<HttpDriverResponse, HttpDriverResponse>> getFile<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
  }) async {
    try {
      final tempDir = await getTemporaryDirectory();
      await tempDir.create(recursive: true);
      String tempPath = tempDir.path;

      final response = await client.download(
        path,
        tempPath,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            if (options != null)
              'Authorization':
                  '${options.accessTokenType} ${options.accessToken}',
            ...?options?.extraHeaders,
          },
        ),
      );

      return Right(
        HttpDriverResponse(
          data: response.data,
          statusCode: response.statusCode,
          statusMessage: response.statusMessage,
        ),
      );
    } on DioError catch (e, s) {
      return Left(_responseError(e, s: s));
    }
  }

  @override
  Map<String, String>? get getHeaders => throw UnimplementedError();

  @override
  Future interceptRequests(Future request) {
    throw UnimplementedError();
  }

  @override
  Future<HttpDriverResponse> patch(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<HttpDriverResponse, HttpDriverResponse>> post(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await client.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            if (options != null)
              'Authorization':
                  '${options.accessTokenType} ${options.accessToken}',
            ...?options?.extraHeaders,
          },
        ),
      );
      return Right(
        HttpDriverResponse(
          data: response.data,
          statusCode: response.statusCode,
          statusMessage: response.statusMessage,
        ),
      );
    } on DioError catch (e, s) {
      return Left(_responseError(e, s: s));
    }
  }

  @override
  Future<HttpDriverResponse> put(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
  }) {
    throw UnimplementedError();
  }

  @override
  void resetContentType() {}

  @override
  Future<HttpDriverResponse> sendFile<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
    HttpDriverProgressCallback? onSendProgress,
  }) {
    throw UnimplementedError();
  }

  @override
  void dispose() {
    client.close();
  }
}
