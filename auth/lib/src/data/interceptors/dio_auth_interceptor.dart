import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

import '../../../auth.dart';

class DioAuthInterceptor extends QueuedInterceptor {
  DioAuthInterceptor({
    required this.localUserUsecase,
    required this.authUsecase,
  });

  final IAuthUsecase authUsecase;
  final ILocalUserUsecase localUserUsecase;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    return localUserUsecase.getSession().then((value) {
      return value.fold(
        (l) => super.onRequest(options, handler),
        (session) async {
          if (!(options.headers.keys.any((h) => h == 'Authorization'))) {
            debugPrint('DioAuthInterceptor => ADDING TOKEN...');
            options.headers.addAll(
              {'Authorization': 'Bearer ${session.externalUser.token}'},
            );
          }
          return super.onRequest(options, handler);
        },
      );
    });
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    switch (err.response?.statusCode) {
      case 401:
        final responseUser = await localUserUsecase.getSession();
        return responseUser.fold(
          (l) async {
            await _finishSession();
            return handler.next(err);
          },
          (session) async {
            debugPrint('DioAuthInterceptor => REFRESHING TOKEN...');
            final responseToken = await authUsecase.refreshToken(
              phone: session.user.phone,
              password: session.user.password,
            );
            return responseToken.fold(
              (l) async {
                await _finishSession();
                return handler.next(err);
              },
              (externalUser) async {
                err.requestOptions.headers.addAll(
                  {'Authorization': 'Bearer ${externalUser.token}'},
                );
                final response = await _getResponse(err.requestOptions);
                return response.fold(
                  (l) async {
                    if (l.response?.statusCode == 401) await _finishSession();
                    return handler.next(err);
                  },
                  (response) async {
                    final responseToken = await localUserUsecase.setSession(
                      session: SessionModel.fromEntity(session).copyWith(
                        externalUser: externalUser,
                      ),
                    );
                    return responseToken.fold(
                      (l) => handler.next(err),
                      (r) => handler.resolve(response),
                    );
                  },
                );
              },
            );
          },
        );
      default:
        return super.onError(err, handler);
    }
  }

  Future<void> _finishSession() async {
    await CustomDialog.show(
      Nav.to.context!,
      CustomAlert.serverError(Nav.to.context!),
      showClose: true,
    ).whenComplete(() => authUsecase.logout());
  }

  Future<Either<DioError, Response>> _getResponse(
    RequestOptions options,
  ) async {
    try {
      final dio = Dio(
        BaseOptions(
          extra: options.extra,
          method: options.method,
          baseUrl: options.baseUrl,
          headers: options.headers,
          contentType: options.contentType,
          listFormat: options.listFormat,
          sendTimeout: options.sendTimeout,
          responseType: options.responseType,
          maxRedirects: options.maxRedirects,
          validateStatus: options.validateStatus,
          connectTimeout: options.connectTimeout,
          receiveTimeout: options.receiveTimeout,
          requestEncoder: options.requestEncoder,
          followRedirects: options.followRedirects,
          responseDecoder: options.responseDecoder,
          queryParameters: options.queryParameters,
          receiveDataWhenStatusError: options.receiveDataWhenStatusError,
        ),
      )..interceptors.add(LogInterceptor());
      final response = await dio.request(
        options.path,
        data: options.data,
        cancelToken: options.cancelToken,
        onSendProgress: options.onSendProgress,
        queryParameters: options.queryParameters,
        onReceiveProgress: options.onReceiveProgress,
        options: Options(
          method: options.method,
          extra: options.extra,
          headers: options.headers,
          listFormat: options.listFormat,
          sendTimeout: options.sendTimeout,
          contentType: options.contentType,
          responseType: options.responseType,
          maxRedirects: options.maxRedirects,
          receiveTimeout: options.receiveTimeout,
          requestEncoder: options.requestEncoder,
          validateStatus: options.validateStatus,
          followRedirects: options.followRedirects,
          responseDecoder: options.responseDecoder,
          receiveDataWhenStatusError: options.receiveDataWhenStatusError,
        ),
      );
      dio.close();
      return Right(response);
    } on DioError catch (e) {
      return Left(e);
    }
  }
}
