import 'dart:async';

import 'package:core/core.dart' hide ServerError, UnknowError;
import '../../../domain/failures/login/login_failure.dart';
import '../../../domain/usecases/i_auth_usecase.dart';
import '../../../domain/usecases/i_login_usecase.dart';
import '../../../domain/usecases/i_user_usecase.dart';
import '../auth/auth_controller.dart';
import '../timer_controller.dart';

class RegisterController extends GenController<ILoginFailure, bool> {
  RegisterController({
    required this.userUsecase,
    required this.authUsecase,
    required this.loginUsecase,
    required this.authController,
    required this.timerController,
  }) : super(false);

  String phoneNumber = '';
  final IUserUsecase userUsecase;
  final IAuthUsecase authUsecase;
  final ILoginUsecase loginUsecase;
  final AuthController authController;
  final TimerController timerController;

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
          authController.token = token;
          final response = await authUsecase.firebaseSignIn(
            token: token.customToken,
          );
          return response.fold((l) => Left(UnknowError(l.toString())),
              (r) async {
            final response = await userUsecase.getFirebaseUser(
              forceRefresh: false,
            );
            return response.fold((l) => Left(UnknowError(l.toString())),
                (firebase) async {
              if (firebase.claims.customerId.isEmpty) {
                return Left(UnknowError('firebase.claims.customerId.isEmpty'));
              }
              authController.claims = firebase.claims;
              final response = await authController.setSession(
                token: authController.token,
              );
              return response.fold((l) => Left(UnknowError(l.toString())),
                  (r) async {
                final response = await userUsecase.getUserById(
                  id: firebase.claims.customerId,
                );
                return response.fold((l) => Left(UnknowError(l.toString())),
                    (customer) async {
                  authController.customer = customer;
                  authController.user = UserEntity(
                    name: customer.name,
                    cpf: customer.cpf,
                    phone: customer.phone,
                    password: customer.id,
                    customerId: customer.id,
                  );
                  final response = await authUsecase.createExternalUser(
                    user: authController.user,
                  );
                  return response.fold((l) async {
                    final response = await authUsecase.refreshToken(
                      phone: customer.phone,
                      password: customer.id,
                    );
                    return response.fold(
                      (l) => Left(UnknowError(l.toString())),
                      (externalUser) async {
                        authController.externalUser = externalUser;
                        return _onSaveSession();
                      },
                    );
                  }, (externalUser) async {
                    authController.externalUser = externalUser;
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
    final sessionResponse = await authController.setSession(
      externalUser: authController.externalUser,
      customer: authController.customer,
      claims: authController.claims,
      token: authController.token,
      user: authController.user,
    );
    return sessionResponse.fold(
      (l) => Left(UnknowError(l.toString())),
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
