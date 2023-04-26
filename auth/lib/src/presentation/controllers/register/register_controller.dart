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
  TokenEntity token = TokenModel.fromMap({});
  final LoginController loginController;
  final IRegisterUsecase registerUsecase;

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
              token = r;
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

  Future<void> onRequestEmailCode({String? accessToken}) async {
    await execute(
      () => registerUsecase.onRequestEmailCode(accessToken: accessToken),
    );
  }

  Future<void> onValidateEmailCode(String token) async {
    await execute(() => registerUsecase.onValidateEmailCode(token: token));
  }

  Future<void> onFinishRegister(CustomerEntity customer) async {
    await execute(
      () => registerUsecase
          .onFinishRegister(customer: customer, accessToken: token.accessToken)
          .then((value) {
        return value.fold((l) => Left(l), (r) async {
          final response = await loginController.onLogin(token: token);
          return response.fold(
            (l) => Left(
              UnknowError(l.message ?? '', detailsMessage: l.detailError),
            ),
            (r) => Right(unit),
          );
        });
      }),
    );
  }
}
