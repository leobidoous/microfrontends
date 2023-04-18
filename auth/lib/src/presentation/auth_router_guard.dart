import 'dart:async';

import 'package:core/core.dart';

import '../../auth.dart';

class AuthRouterGuard extends RouteGuard {
  AuthRouterGuard({required this.path}) : super(redirectTo: path.completePath);

  final BasePath path;

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
