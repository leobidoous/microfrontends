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
          await appController.authUsecase
              .createExternalUser(user: session.user)
              .then((value) async {
            return value.fold((l) => setError(Exception(l.data)),
                (externalUser) async {
              await userUsecase
                  .getUserById(id: session.customer.id)
                  .then((value) {
                return value.fold((l) => setError(l), (customer) async {
                  await appController.localUserUsecase
                      .setSession(
                    session: SessionModel.fromEntity(session).copyWith(
                      externalUser: externalUser,
                      customer: customer,
                    ),
                  )
                      .then((value) {
                    return value.fold((l) => setError(l), (r) => update(true));
                  });
                });
              });
            });
          });
        },
      );
    });
  }

  Future<void> checkLatestVersion() async {}
}
