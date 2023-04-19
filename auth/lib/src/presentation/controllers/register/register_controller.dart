import 'package:core/core.dart';

import '../../../domain/failures/login_failure.dart';
import '../../../domain/usecases/i_register_usecase.dart';
import '../login/login_controller.dart';

class RegisterController extends GenController<ILoginFailure, bool> {
  RegisterController({
    required this.loginController,
    required this.registerUsecase,
  }) : super(false);

  final LoginController loginController;
  final IRegisterUsecase registerUsecase;
}
