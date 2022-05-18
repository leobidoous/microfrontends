import 'dart:async';

import 'package:base_auth/base_auth.dart';
import 'package:core/core.dart';

import '../app_routes.dart';

class LoggedRouterGuard extends RouteGuard {
  LoggedRouterGuard() : super(redirectTo: '${AppRoutes.auth}/',);
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    final usecase = Modular.get<LoggedUserUsecase>();
    final response = await usecase.getLoggedUser();
    return response.fold((l) => false, (r) => true);
  }
}
