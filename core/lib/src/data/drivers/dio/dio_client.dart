import '../../../../core.dart';
import 'default_interceptors.dart';

class DioClient extends IHttpDriver {
  final Dio client;

  DioClient({required this.client}) {
    client.interceptors.add(LogInterceptor());
    client.interceptors.add(DefaultInterceptors());
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
  Future<HttpDriverResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
    Map<String, dynamic>? extraHeaders,
  }) {
    throw UnimplementedError();
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
