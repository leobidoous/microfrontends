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

  Future<void> loginWithEmail(LoginEmailEntity data) async {
    setLoading(true);
    await loginUsecase(data: data)
        .then(
          (value) => value.fold((l) => setError(l), (token) async {
            final response = await localUserUsecase.setToken(token: token);
            return response.fold((l) => setError(l), (r) {
              update(true);
            });
          }),
        )
        .whenComplete(() => setLoading(false));
  }
}
