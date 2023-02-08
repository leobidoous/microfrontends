import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../domain/usecases/auth/logout_usecase.dart';
import '../../../domain/usecases/auth/token_usecase.dart';

class AuthInterceptor extends QueuedInterceptor {
  final ILocalUserUsecase localUserUsecase;
  final ILogoutUsecase logoutUsecase;
  final ITokenUsecase tokenUsecase;

  AuthInterceptor({
    required this.localUserUsecase,
    required this.logoutUsecase,
    required this.tokenUsecase,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    return localUserUsecase.getToken().then((value) {
      return value.fold(
        (l) => super.onRequest(options, handler),
        (token) async {
          debugPrint('AuthInterceptor => ADDING TOKEN...');
          options.headers.addAll(
            {'Authorization': 'Bearer ${token.tokenData.token}'},
          );
          return super.onRequest(options, handler);
        },
      );
    });
  }

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    switch (err.response?.statusCode) {
      case 401:
        final token = await localUserUsecase.getToken();
        return token.fold(
          (l) async {
            await _finishSession();
            return handler.next(err);
          },
          (token) async {
            debugPrint('AuthInterceptor => REFRESHING TOKEN...');
            final refreshToken = await tokenUsecase.refreshToken(
              token: token.tokenData,
            );
            return refreshToken.fold(
              (l) async {
                await _finishSession();
                return handler.next(err);
              },
              (refreshToken) async {
                err.requestOptions.headers.addAll(
                  {'Authorization': 'Bearer ${refreshToken.tokenData.token}'},
                );
                final response = await _getResponse(err.requestOptions);
                return response.fold(
                  (l) async {
                    if (l.response?.statusCode == 401) await _finishSession();
                    return handler.next(err);
                  },
                  (response) async {
                    await localUserUsecase
                        .setToken(token: refreshToken)
                        .then((value) {
                      return value.fold(
                        (l) => handler.next(err),
                        (r) => handler.resolve(response),
                      );
                    });
                  },
                );
              },
            );
          },
        );

      default:
        break;
    }
    return super.onError(err, handler);
  }

  Future<void> _finishSession() async {
    await Nav.to
        .push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black87,
        pageBuilder: (_, __, ___) => const ConfirmExitView(),
      ),
    )
        .whenComplete(
      () async {
        await logoutUsecase();
        Nav.to.navigate(Nav.to.initialRoute);
      },
    );
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
