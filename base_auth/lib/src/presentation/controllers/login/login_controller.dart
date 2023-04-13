import 'dart:async';
import 'dart:convert';

import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../domain/failures/login/login_failure.dart';
import '../../../domain/usecases/i_auth_usecase.dart';
import '../../../domain/usecases/i_login_usecase.dart';
import 'login_timer_controller.dart';

class LoginController extends GenController<ILoginFailure, bool> {
  LoginController({
    required this.userUsecase,
    required this.authUsecase,
    required this.loginUsecase,
    required this.appController,
    required this.timerController,
    required this.globalController,
    required this.globalAuthController,
    required this.mixpanel,
  }) : super(false);

  String phoneNumber = '';
  final IUserUsecase userUsecase;
  final IAuthUsecase authUsecase;
  final ILoginUsecase loginUsecase;
  final AppController appController;
  final MixPanelController mixpanel;
  final GlobalController globalController;
  final LoginTimerController timerController;
  final GlobalAuthController globalAuthController;

  Future<void> onRequestCode({required String phone}) async {
    timerController.startTimer();
    await execute(
      () => loginUsecase.onRequestCode(phone: phone).then((value) {
        return value.fold((l) => Left(l), (r) => Right(false));
      }),
    );
  }

  Future<void> onResendCode() async {
    timerController.startTimer();
    loginUsecase.onRequestCode(phone: phoneNumber);
  }

  Future<void> onValidateCode({
    required String code,
    required String phone,
  }) async {
    await execute(
      () => loginUsecase.onValidateCode(phone: phone, code: code).then((value) {
        return value.fold((l) => Left(l), (token) async {
          appController.token = token;
          final response = await authUsecase.firebaseSignIn(
            token: token.customToken,
          );
          return response.fold((l) => Left(UnknowError('')), (r) async {
            final response = await userUsecase.getFirebaseUser(
              forceRefresh: false,
            );
            return response.fold((l) => Left(UnknowError('')),
                (firebase) async {
              if (firebase.claims.customerId.isEmpty) {
                return Left(UnknowError(''));
              }

              debugPrint(
                jsonEncode(ClaimsModel.fromEntity(firebase.claims).toMap),
              );

              appController.claims = firebase.claims;
              final response = await appController.onSaveSession(
                token: appController.token,
              );
              return response.fold((l) => Left(UnknowError('')), (r) async {
                final response = await userUsecase.getUserById(
                  id: firebase.claims.customerId,
                );
                return response.fold((l) => Left(UnknowError('')),
                    (customer) async {
                  appController.customer = customer;
                  appController.user = UserEntity(
                    name: customer.name,
                    cpf: customer.cpf,
                    phone: customer.phone,
                    password: customer.id,
                    customerId: customer.id,
                  );
                  final response = await authUsecase.createExternalUser(
                    user: appController.user,
                  );
                  return response.fold((l) async {
                    final response = await authUsecase.refreshToken(
                      phone: customer.phone,
                      password: customer.id,
                    );
                    return response.fold(
                      (l) => Left(UnknowError('')),
                      (externalUser) async {
                        appController.externalUser = externalUser;
                        return _onSaveSession();
                      },
                    );
                  }, (externalUser) async {
                    appController.externalUser = externalUser;
                    return _onSaveSession();
                  });
                });
              });
            });
          });
        });
      }),
    );
  }

  Future<Either<ILoginFailure, bool>> _onSaveSession() async {
    PushNotifications.setUpTokenForUser(
      FirebaseAuth.instance.currentUser!.uid,
    );
    final sessionResponse = await appController.onSaveSession(
      externalUser: appController.externalUser,
      customer: appController.customer,
      claims: appController.claims,
      token: appController.token,
      user: appController.user,
    );
    return sessionResponse.fold(
      (l) => Left(UnknowError('')),
      (r) => Right(true),
    );
  }

  bool _phoneIsValid = false;
  bool get phoneIsValid => _phoneIsValid;
  bool validatePhone(String phone) {
    update(state, force: true);
    _phoneIsValid = phone.length >= 15;
    return _phoneIsValid;
  }

  bool _codeIsValid = false;
  bool get codeIsValid => _codeIsValid;
  bool validateCode(String code) {
    update(state, force: true);
    _codeIsValid = code.length == 6;
    return _codeIsValid;
  }
}
