
import 'package:dartz/dartz.dart';

class HttpDriverResponse {
  final dynamic data;
  final int? statusCode;
  String? statusMessage;

  HttpDriverResponse({
    required this.data,
    this.statusCode,
    this.statusMessage,
  });
}

class HttpDriverOptions {
  final AccessToken? accessToken;
  final BaseUrl? baseUrl;
  final String accessTokenType;
  final String? tenantId;
  final String? channelId;
  final String? apiKey;
  final CustomerId? customerId;
  final Map<String, dynamic>? extraHeaders;
  HttpDriverOptions({
    this.accessToken,
    this.baseUrl,
    this.tenantId,
    this.channelId,
    this.apiKey,
    this.accessTokenType = 'Bearer',
    this.customerId,
    this.extraHeaders,
  });
}

typedef HttpDriverProgressCallback = void Function(int count, int total);
typedef AccessToken = String;
typedef CustomerId = String Function();
typedef BaseUrl = String Function();
typedef CallbackType<T> = T Function();

abstract class IHttpDriver {
  Future<Either<HttpDriverResponse, HttpDriverResponse>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
  });

  Future<HttpDriverResponse> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
  });

  Future<HttpDriverResponse> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
  });

  Future<Either<HttpDriverResponse, HttpDriverResponse>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
  });

  Future<HttpDriverResponse> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
  });

  Future<HttpDriverResponse> sendFile<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
    HttpDriverProgressCallback? onSendProgress,
  });

  Future<Either<HttpDriverResponse, HttpDriverResponse>> getFile<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
  });

  void resetContentType();

  Future<dynamic> interceptRequests(Future request);

  Map<String, String>? get getHeaders;
}
