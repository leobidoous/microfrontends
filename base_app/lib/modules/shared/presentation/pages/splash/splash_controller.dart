import 'dart:async';

import 'package:core/core.dart';

import '../../../../app/domain/usecases/i_user_usecase.dart';
import '../../../../app/presentation/controllers/app_controller.dart';

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
          final response = await userUsecase.getUserById(
            id: session.customer.id,
          );
          return response.fold((l) => setError(l), (r) => update(true));
        },
      );
    });
  }

  Future<void> checkLatestVersion() async {}
}
