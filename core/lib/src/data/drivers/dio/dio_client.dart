import '../../../../core.dart';

class DioClient extends IHttpDriver {
  final Dio client;

  DioClient({required this.client}) {
    client.interceptors.add(DefaultInterceptors());
    // client.interceptors.add(LogInterceptor());
  }

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
    Map<String, dynamic>? extraHeaders,
  }) async {
    try {
      final response = await client.get(
        path,
        queryParameters: queryParameters,
      );
      return Right(HttpDriverResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      ));
    } on DioError catch (e) {
      return Left(HttpDriverResponse(
        data: e.response?.data ?? 'Erro não tratado pelo Back-End',
        statusCode: e.response?.statusCode,
        statusMessage: e.message,
      ));
    }
  }

  @override
  Future<HttpDriverResponse> getFile<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
  }) {
    throw UnimplementedError();
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
  Future<HttpDriverResponse> post(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
  }) {
    throw UnimplementedError();
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
}
