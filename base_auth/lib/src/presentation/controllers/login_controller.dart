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
    Future<Either<Exception, UserEntity>> Function(TokenEntity) onLoginCallback,
  ) async {
    setLoading(true);
    await loginUsecase(data: data)
        .then(
          (value) => value.fold((l) => setError(l), (token) async {
            return await onLoginCallback(token).then(
              (value) => value.fold((l) => setError(l), (r) => update(true)),
            );
          }),
        )
        .whenComplete(() => setLoading(false));
  }
}
