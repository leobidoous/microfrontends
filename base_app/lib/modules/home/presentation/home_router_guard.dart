import 'dart:async';

import 'package:base_auth/base_auth.dart';
import 'package:core/core.dart';

class HomeRouterGuard extends RouteGuard {
  HomeRouterGuard() : super(redirectTo: AuthRoutes.root.completePath);
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    final usecase = DM.i.get<LocalUserUsecase>();
    final authUsecase = DM.i.get<AuthUsecase>();
    return await usecase.getSession().then((value) async {
      return value.fold(
        (l) => false,
        (session) => authUsecase.sessionIsValid(session),
      );
    });
  }
}
