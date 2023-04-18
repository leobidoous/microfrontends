import 'dart:async';

import 'package:auth/auth.dart';
import 'package:core/core.dart';

import '../../../app/presentation/controllers/app_controller.dart';

class SplashController extends GenController<Exception, bool> {
  SplashController({
    required this.appController,
    required this.userUsecase,
  }) : super(false);

  bool needUpdate = false;
  bool forceUpdate = false;
  final AppController appController;
  final IUserUsecase userUsecase;

  Future<void> onInit() async {
    await appController.getSession().then((value) async {
      await checkLatestVersion();
      return value.fold(
        (l) => setError(l),
        (session) async {
          return await appController.authUsecase
              .createExternalUser(user: session.user)
              .then((value) async {
            return value.fold((l) => setError(Exception(l.data)), (r) async {
              return await appController.localUserUsecase
                  .setSession(
                session: SessionModel.fromEntity(session).copyWith(
                  externalUser: r,
                ),
              )
                  .then((value) async {
                return await userUsecase
                    .getUserById(id: session.customer.id)
                    .then((value) {
                  return value.fold((l) => setError(l), (r) => update(true));
                });
              });
            });
          });
        },
      );
    });
  }
  // Future<void> onInit() async {
  //   await appController.getSession().then((value) async {
  //     await checkLatestVersion();
  //     return value.fold(
  //       (l) => setError(l),
  //       (session) {
  // return appController.authUsecase
  //     .createExternalUser(user: session.user)
  //     .then((value) {
  //   return value.fold((l) => Left(l), (r) {
  //     return userUsecase
  //         .getUserById(id: session.customer.id)
  //         .then((value) async {
  //       print(1231231231);
  //       await Future.delayed(const Duration(seconds: 2));
  //       return value.fold(
  //         (l) => setError(l),
  //         (r) => update(true),
  //       );
  //     });
  //           });
  //         });
  //       },
  //     );
  //   });
  // }

  Future<void> checkLatestVersion() async {}
}
