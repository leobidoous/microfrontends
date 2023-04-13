import 'dart:async';

import 'package:core/core.dart';

class AuthRouterGuard extends RouteGuard {
  final BasePath path;
  AuthRouterGuard({required this.path}) : super(redirectTo: path.completePath);
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    final usecase = DM.i.get<LocalUserUsecase>();
    return await usecase.getSession().then((value) async {
      return value.fold((l) => true, (r) => false);
    });
  }
}
