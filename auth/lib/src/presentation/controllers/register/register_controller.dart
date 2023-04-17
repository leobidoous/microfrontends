import 'package:auth/src/presentation/controllers/login/login_controller.dart';
import 'package:core/core.dart' hide ServerError, UnknowError;
import '../../../domain/failures/login/login_failure.dart';

class RegisterController extends GenController<ILoginFailure, bool> {
  RegisterController({
    required this.loginController,
  }) : super(false);

  final LoginController loginController;

  bool _phoneIsValid = false;
  bool get phoneIsValid => _phoneIsValid;
  bool validatePhone(String phone) {
    update(state, force: true);
    _phoneIsValid = phone.length >= 15;
    return _phoneIsValid;
  }

  bool _codeIsValid = false;
  bool get codeIsValid => _codeIsValid;
  bool validateCode(String code) {
    update(state, force: true);
    _codeIsValid = code.length == 6;
    return _codeIsValid;
  }
}
