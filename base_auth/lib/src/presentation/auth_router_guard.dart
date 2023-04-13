import 'dart:async';

import 'package:core/core.dart';

import '../../base_auth.dart';

class AuthRouterGuard extends RouteGuard {
  final BasePath path;
  AuthRouterGuard({required this.path}) : super(redirectTo: path.completePath);
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    final usecase = DM.i.get<LocalUserUsecase>();
    final authUsecase = DM.i.get<AuthUsecase>();
    return await usecase.getSession().then((value) async {
      return value.fold(
        (l) => true,
        (session) => !authUsecase.sessionIsValid(session),
      );
    });
  }
}
