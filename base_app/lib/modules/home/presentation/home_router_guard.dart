import 'dart:async';

import 'package:auth/auth.dart';
import 'package:core/core.dart';

import '../../app/presentation/app_routes.dart';

class HomeRouterGuard extends RouteGuard {
  HomeRouterGuard()
      : super(
          redirectTo: AuthRoutes(parent: AppRoutes.root).initial.completePath,
        );
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
