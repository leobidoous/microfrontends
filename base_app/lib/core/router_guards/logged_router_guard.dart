import 'dart:async';

import 'package:base_auth/base_auth.dart';
import 'package:core/core.dart';

import '../app_routes.dart';

class LoggedRouterGuard extends RouteGuard {
  LoggedRouterGuard() : super(redirectTo: '${AppRoutes.auth}/');
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    final loggedUserUsecase = Modular.get<LoggedUserUsecase>();
    final loggedUserStore = Modular.get<LoggedUserStore>();
    /// Verifica se o usuário está autenticado e se a instância global
    /// do usuário no app foi inicializada.
    return await loggedUserUsecase.getLoggedUser().then((value) {
      return value.fold((l) => false, (r) => loggedUserStore.state);
    });
  }
}
