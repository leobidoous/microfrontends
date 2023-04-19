import 'package:core/core.dart';

import '../../../domain/failures/register_failure.dart';
import '../../../domain/usecases/i_register_usecase.dart';
import '../login_controller.dart';

class RegisterController extends GenController<IRegisterFailure, Unit> {
  RegisterController({
    required this.loginController,
    required this.registerUsecase,
  }) : super(unit);

  String phoneNumber = '';
  final LoginController loginController;
  final IRegisterUsecase registerUsecase;

  Future<void> onStartRegister({
    required String phone,
    required String name,
    required String cpf,
  }) async {
    await execute(
      () => registerUsecase.onStartRegister(phone: phone, name: name, cpf: cpf),
    );
  }

  Future<void> onValidateCpfAlreadyExists({required String cpf}) async {
    await execute(
      () => registerUsecase.onValidateCpfAlreadyExists(cpf: cpf),
    );
  }

  Future<void> onFinishRegister({required CustomerEntity customer}) async {
    await execute(
      () => registerUsecase.onFinishRegister(customer: customer),
    );
  }
}
