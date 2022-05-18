class HttpDriverResponse {
  final dynamic data;
  final int? statusCode;
  String? statusMessage;

  HttpDriverResponse({
    required this.data,
    required this.statusCode,
    this.statusMessage,
  });
}

class HttpDriverOptions {
  final AccessToken accessToken;
  final BaseUrl baseUrl;
  final String accessTokenType;
  final String tenantId;
  final String channelId;
  final String apiKey;
  final CustomerId? customerId;

  HttpDriverOptions({
    required this.accessToken,
    required this.baseUrl,
    required this.tenantId,
    required this.channelId,
    required this.apiKey,
    this.accessTokenType = 'Bearer',
    this.customerId,
  });
}

typedef HttpDriverProgressCallback = void Function(int count, int total);
typedef AccessToken = String Function();
typedef CustomerId = String Function();
typedef BaseUrl = String Function();
typedef CallbackType<T> = T Function();

abstract class IHttpDriver {
  Future<dynamic> interceptRequests(Future request);
  Future<HttpDriverResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
    Map<String, dynamic>? extraHeaders,
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

  Future<HttpDriverResponse> post(
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

  Future<HttpDriverResponse> getFile<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
  });

  void resetContentType();
  Map<String, String>? get getHeaders;
}
