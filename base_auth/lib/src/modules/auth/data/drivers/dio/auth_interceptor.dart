import 'dart:developer';

import 'package:core/core.dart'
    show
        QueuedInterceptor,
        Disposable,
        DioClientDriver,
        RequestOptions,
        RequestInterceptorHandler,
        Response,
        ResponseInterceptorHandler,
        DioError,
        ErrorInterceptorHandler,
        Modular,
        Dio,
        BaseOptions,
        Either,
        DefaultInterceptor,
        Options,
        Right,
        Left;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../../base_auth.dart';
import '../../../../../core/constants/scope_constants.dart';
import '../../../presentation/shared/widgets/finished_session.dart';

class AuthInterceptor extends QueuedInterceptor with Disposable {
  final DioClientDriver client;
  final IMicrosoftSSOUsecase ssoUsecase;
  final ILoggedUserUsecase loggedUserUsecase;

  AuthInterceptor({
    required this.client,
    required this.ssoUsecase,
    required this.loggedUserUsecase,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    return loggedUserUsecase.getSavedUser().then((value) {
      value.fold(
        (l) => super.onRequest(options, handler),
        (user) async {
          if (kDebugMode) {
            log('AuthInterceptor => ADDING TOKEN...');
          }
          options.headers.addAll(
            {'Authorization': 'Bearer ${user.sharepointToken.accessToken}'},
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
        return loggedUserUsecase.getSavedUser().then((value) {
          value.fold(
            (l) async {
              await _finishSession();
              return handler.next(err);
            },
            (user) async {
              if (kDebugMode) {
                log('AuthInterceptor => REFRESHING TOKEN...');
              }
              return ssoUsecase
                  .refreshToken(
                token: user.sharepointToken.refreshToken,
                scope: ScopeConstants.blob,
              )
                  .then((value) {
                value.fold(
                  (l) async {
                    await _finishSession();
                    return handler.next(err);
                  },
                  (sharepointToken) async {
                    err.requestOptions.headers.addAll(
                      {
                        'Authorization': 'Bearer ${sharepointToken.accessToken}'
                      },
                    );
                    final response = await _getResponse(err.requestOptions);
                    return response.fold(
                      (l) async {
                        await _finishSession();
                        return handler.next(err);
                      },
                      (r) async {
                        user.sharepointToken = sharepointToken;
                        await loggedUserUsecase.saveLoggedUser(user: user);
                        return handler.resolve(r);
                      },
                    );
                  },
                );
              });
            },
          );
        });
      default:
        break;
    }
    return super.onError(err, handler);
  }

  Future<void> _finishSession() async {
    await Modular.to
        .push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black87,
        pageBuilder: (_, __, ___) => const FinishedSession(),
      ),
    )
        .whenComplete(
      () async {
        await loggedUserUsecase.removeSavedUser();
        Modular.to.navigate(Modular.initialRoute);
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
      )..interceptors.add(DefaultInterceptor());
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

  @override
  void dispose() {
    client.client.close();
  }
}
