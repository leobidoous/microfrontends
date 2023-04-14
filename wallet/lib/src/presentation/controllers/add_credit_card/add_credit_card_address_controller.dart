import 'package:core/core.dart';

class AddCreditCardAddressController
    extends GenController<Exception, PostalCodeEntity> {
  final ISearchPostalCodeUsecase usecase;
  AddCreditCardAddressController({
    required this.usecase,
  }) : super(PostalCodeModel.fromMap({}));

  Future<void> searchPostalCode(String postalCode) async {
    await execute(
      () => usecase(postalCode: postalCode.replaceAll(RegExp(r'[^0-9]'), '')),
    );
  }
}
