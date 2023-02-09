import 'package:core/core.dart';

import '../../../../modules/app/domain/usecases/user_usecase.dart';
import '../../../../modules/app/presentation/app_controller.dart';

class SplashController extends DefaultController<Exception, bool> {
  final IUserUsecase userUsecase;
  final AppController appController;
  final ILocalUserUsecase localUserUsecase;

  SplashController({
    required this.userUsecase,
    required this.appController,
    required this.localUserUsecase,
  }) : super(false);

  Future<void> getLoggedlUser() async {
    setLoading(true);
    final token = await localUserUsecase.getToken();
    return token.fold((l) => setError(l), (token) async {
      final user = await userUsecase.getUserById(id: token.clientId);
      return user.fold(
        (l) => setError(l),
        (user) async {
          final response = await localUserUsecase.setLocalUser(user: user);
          return response.fold(
            (l) => setError(l),
            (r) {
              appController.user = user;
              update(true);
            },
          );
        },
      );
    });
  }
}
