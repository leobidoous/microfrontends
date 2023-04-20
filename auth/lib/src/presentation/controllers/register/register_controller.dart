import 'package:core/core.dart';

import '../../../domain/failures/register_failure.dart';
import '../../../domain/usecases/i_auth_usecase.dart';
import '../../../domain/usecases/i_login_usecase.dart';
import '../../../domain/usecases/i_register_usecase.dart';
import '../auth_controller.dart';
import '../login_controller.dart';

class RegisterController extends GenController<IRegisterFailure, Unit> {
  RegisterController({
    required this.loginController,
    required this.registerUsecase,
    required this.loginUsecase,
    required this.authController,
    required this.authUsecase,
  }) : super(unit);

  String phoneNumber = '';
  String accessToken = '';
  final LoginController loginController;
  final IRegisterUsecase registerUsecase;
  final ILoginUsecase loginUsecase;
  final AuthController authController;
  final IAuthUsecase authUsecase;

  CustomerModel _customer = CustomerModel.fromMap({});
  CustomerModel get customer => _customer;

  void onUpdateForm({
    BillingAddressEntity? address,
    String? cpf,
    String? email,
    String? name,
    String? phone,
    String? termAcceptedAt,
  }) {
    _customer = _customer.copyWith(
      address: address,
      cpf: cpf?.replaceAll(RegExp(r'[^0-9]'), ''),
      email: email,
      name: name,
      termAcceptedAt: termAcceptedAt,
      phone: phone?.replaceAll(RegExp(r'[^0-9]'), ''),
    );
  }

  Future<void> onStartRegister({required String phone}) async {
    await execute(
      () => registerUsecase.onStartRegister(
        phone: phone,
        name: _customer.name,
        cpf: _customer.cpf,
      ),
    );
    if (!hasError) {
      phoneNumber = phone;
    } else {
      phoneNumber = '';
    }
  }

  Future<void> onValidatePhoneCode({required String code}) async {
    await execute(
      () => registerUsecase
          .onValidatePhoneCode(code: code, phone: phoneNumber)
          .then(
            (value) => value.fold((l) => Left(l), (r) {
              accessToken = r;
              return Right(unit);
            }),
          ),
    );
  }

  Future<void> onValidateCpfAlreadyExists({required String cpf}) async {
    await execute(
      () => registerUsecase.onValidateCpfAlreadyExists(cpf: cpf).then((value) {
        return value.fold((l) => Left(l), (r) => Right(unit));
      }),
    );
  }

  Future<void> onFinishRegister(CustomerEntity customer) async {
    await execute(
      () => registerUsecase.onFinishRegister(
        customer: customer,
        accessToken: accessToken,
      ),
    );
  }
}
