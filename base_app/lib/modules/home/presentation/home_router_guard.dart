import 'dart:async';

import 'package:core/core.dart';

import '../../app/presentation/app_routes.dart';

class HomeRouterGuard extends RouteGuard {
  HomeRouterGuard() : super(redirectTo: AppRoutes.auth.completePath);
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    final usecase = DM.i.get<LocalUserUsecase>();
    return await usecase.getSession().then((value) async {
      return value.fold((l) => false, (r) => true);
    });
  }
}
