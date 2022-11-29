import 'dart:async';

import 'package:base_auth/base_auth.dart';
import 'package:core/core.dart';

import '../../app/app_routes.dart';
import '../../app/stores/user_store.dart';

class LoggedRouterGuard extends RouteGuard {
  LoggedRouterGuard() : super(redirectTo: AppRoutes.auth.completePath);
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    final usecase = Modular.get<LoggedUserUsecase>();
    final userStore = Modular.get<UserStore>();
    final response = await usecase.getSavedUser();
    return response.fold(
      (l) => false,
      (r) {
        userStore.onChangeUser(r);
        return true;
      },
    );
  }
}
