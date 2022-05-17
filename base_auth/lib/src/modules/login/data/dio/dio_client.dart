import 'package:core/core.dart';

import 'auth_interceptors.dart';

class DioClient extends HttpDatasource {
  final Dio client;

  DioClient({required this.client}) {
    client.interceptors.add(LogInterceptor());
    client.interceptors.add(AuthInterceptors());
  }
}
