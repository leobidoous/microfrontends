import 'package:core/core.dart';

import '../../../auth.dart';
import '../../domain/failures/register_failure.dart';
import '../../domain/usecases/i_register_usecase.dart';

class ValidateEmailController extends GenController<IRegisterFailure, Unit> {
  ValidateEmailController({
    required this.userUsecase,
    required this.registerUsecase,
  }) : super(unit);

  final IRegisterUsecase registerUsecase;
  final IUserUsecase userUsecase;
  String email = '';

  Future<void> onValidateEmailCode(String token) async {
    await execute(() => registerUsecase.onValidateEmailCode(token: token));
  }

  Future<void> onRequestEmailCode({String? accessToken}) async {
    await execute(
      () => registerUsecase.onRequestEmailCode(accessToken: accessToken),
    );
  }

  Future<void> updateUser(
    CustomerEntity customer,
    Future Function(CustomerEntity) onValidateCallback,
  ) async {
    await execute(
      () => userUsecase.updateUser(customer: customer).then((value) {
        return value.fold(
          (l) => Left(UnknowError(l.toString())),
          (customer) async {
            await onValidateCallback(customer);
            return Right(unit);
          },
        );
      }),
    );
  }
}
