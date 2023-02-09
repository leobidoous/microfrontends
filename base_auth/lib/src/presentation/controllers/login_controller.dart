import 'package:core/core.dart';

import '../../domain/entities/login_email_entity.dart';
import '../../domain/usecases/login/login_with_email_usecase.dart';

class LoginController extends DefaultController<Exception, bool> {
  final ILoginWithEmailUsecase loginUsecase;
  final ILocalUserUsecase localUserUsecase;

  LoginController({
    required this.loginUsecase,
    required this.localUserUsecase,
  }) : super(false);

  Future<void> loginWithEmail(
    LoginEmailEntity data,
    Future Function(UserEntity) onLoginCallback,
  ) async {
    setLoading(true);
    await loginUsecase(data: data)
        .then(
          (value) => value.fold((l) => setError(l), (token) async {
            final user = UserModel.fromMap({});
            final response = await localUserUsecase.setLocalUser(user: user);
            return response.fold((l) => setError(l), (r) async {
              await onLoginCallback(user);
              update(true);
            });
          }),
        )
        .whenComplete(() => setLoading(false));
  }
}
