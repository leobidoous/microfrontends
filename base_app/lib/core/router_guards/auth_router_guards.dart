import 'dart:async';

import 'package:base_auth/base_auth.dart';
import 'package:core/core.dart';

import '../../app/modules/home/presentation/home_routes.dart';

class AuthRouterGuard extends RouteGuard {
  AuthRouterGuard() : super(redirectTo: HomeRoutes.home.completePath);
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    final usecase = Modular.get<LoggedUserUsecase>();
    final response = await usecase.getSavedUser();
    return response.fold((l) => true, (r) => false);
  }
}
