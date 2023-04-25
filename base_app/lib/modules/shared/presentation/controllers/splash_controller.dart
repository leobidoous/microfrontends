import 'dart:async';
import 'dart:io';

import 'package:auth/auth.dart';
import 'package:core/core.dart';

import '../../../app/domain/usecases/i_app_usecase.dart';
import '../../../app/presentation/app_configuration.dart';
import '../../../app/presentation/controllers/app_controller.dart';

class SplashController extends GenController<Exception, bool> {
  SplashController({
    required this.appConfiguration,
    required this.appController,
    required this.userUsecase,
    required this.appUsecase,
  }) : super(false);

  bool needUpdate = false;
  bool forceUpdate = false;
  final AppConfiguration appConfiguration;
  final AppController appController;
  final IUserUsecase userUsecase;
  final IAppUsecase appUsecase;

  Future<void> verifySession() async {
    await checkLatestVersion();
    await appController.getSession().then((value) async {
      return value.fold(
        (l) async {
          await appController.getUserPreferences('');
          return setError(l);
        },
        (session) async {
          await appController.getUserPreferences(session.customer.id);
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

  Future<void> checkLatestVersion() async {
    final isIos = Platform.isIOS;
    final packageInfo = await appConfiguration.getAppInfo();
    final currentVersion = PackageInfoModel.fromEntity(packageInfo)
        .getExtendedVersionNumber(packageInfo.version);
    final currentBuild = packageInfo.buildNumber;
    late final Either<Exception, PackageInfoEntity> response;
    if (isIos) {
      response = await appUsecase.getAppVersion(
        product: 'b2c',
        platform: 'ios',
      );
    } else {
      response = await appUsecase.getAppVersion(
        product: 'b2c',
        platform: 'android',
      );
    }

    response.fold((l) => Left(l), (r) {
      if (PackageInfoModel.fromEntity(r).getExtendedVersionNumber(r.version) >
              currentVersion ||
          r.buildNumber > currentBuild) {
        needUpdate = true;
      } else {
        needUpdate = false;
      }

      forceUpdate = r.forceUpdate;
    });
  }
}
