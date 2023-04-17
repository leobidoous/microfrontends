import 'package:core/core.dart';

class RegisterAddressController
    extends GenController<Exception, PostalCodeEntity> {
  RegisterAddressController({
    required this.usecase,
  }) : super(PostalCodeModel.fromMap({}));
  
  final ISearchPostalCodeUsecase usecase;

  Future<void> searchPostalCode(String postalCode) async {
    await execute(
      () => usecase(postalCode: postalCode.replaceAll(RegExp(r'[^0-9]'), '')),
    );
  }
}
