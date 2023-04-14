import 'package:core/core.dart';


class CreditCardAddressController 
    extends GenController<Exception, PostalCodeEntity> {
  final ISearchPostalCodeUsecase usecase;
  CreditCardAddressController({
    required this.usecase,
  }) : super(PostalCodeModel.fromMap({}));

  Future<void> searchPostalCode(String postalCode) async {
    await execute(
      () => usecase(
        postalCode: postalCode.replaceAll(RegExp(r'[^0-9]'), ''),
      ),
    );
  }
}
