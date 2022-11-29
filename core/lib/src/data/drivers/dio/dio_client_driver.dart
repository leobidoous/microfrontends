import 'dart:async';
import 'dart:io';

import '../../../../core.dart';
import '../../../utils/file_name_from_path.dart';

class DioClientDriver extends IHttpDriver with Disposable {
  final Dio client;

  DioClientDriver({required this.client});

  @override
  Future<HttpDriverResponse> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
  }) {
    throw UnimplementedError();
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
            'Authorization':
                '${options?.accessTokenType} ${options?.accessToken}',
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
    } on DioError catch (e) {
      return Left(
        HttpDriverResponse(
          data: e.response?.data ?? 'Ocorreu um erro inesperado.\n${e.message}',
          statusCode: e.response?.statusCode,
          statusMessage: e.response?.statusCode == null
              ? 'Ocorreu um erro inesperado, talvez você '
                  'esteja sem acesso à internet.\n${e.message}'
              : e.message,
        ),
      );
    }
  }

  @override
  Future<Either<HttpDriverResponse, HttpDriverResponse>> getFile<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
  }) async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      await tempDir.create(recursive: true);
      String tempPath = tempDir.path;
      final nameFileForPath = FileNameFromPath().call(completPath: path);

      final response = await client.download(
        path,
        '$tempPath/$nameFileForPath',
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Authorization':
                '${options?.accessTokenType} ${options?.accessToken}',
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
    } on DioError catch (e) {
      return Left(
        HttpDriverResponse(
          data: e.response?.data ?? 'Ocorreu um erro inesperado.\n${e.message}',
          statusCode: e.response?.statusCode,
          statusMessage: e.response?.statusCode == null
              ? 'Ocorreu um erro inesperado, talvez você '
                  'esteja sem acesso à internet.\n${e.message}'
              : e.message,
        ),
      );
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
            '${options?.accessTokenType}': '${options?.accessToken}',
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
    } on DioError catch (e) {
      return Left(
        HttpDriverResponse(
          data: e.response?.data ?? 'Erro interno\n${e.message}',
          statusCode: e.response?.statusCode,
          statusMessage: e.message,
        ),
      );
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
