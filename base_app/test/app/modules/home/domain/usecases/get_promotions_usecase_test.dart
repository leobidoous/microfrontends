import 'package:base_app/app/modules/home/domain/entities/product_entity.dart';
import 'package:base_app/app/modules/home/domain/repositories/get_promotions_repository.dart';
import 'package:base_app/app/modules/home/domain/usecases/get_promotions_usecase.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_promotions_usecase_test.mocks.dart';

@GenerateMocks([IGetPromotionsRepository])
void main() {
  final repositoryMock = MockIGetPromotionsRepository();

  test('Deve retornar uma lista de ProductEntity', () async {
    final usecase = GetPromotionsUsecase(repository: repositoryMock);
    when(usecase()).thenAnswer(
      (_) async => Right([
        ProductEntity(
          name: 'name',
          image: 'image',
          price: 10.0,
          oldPrice: 15.0,
          rate: 5,
          reviews: 10,
          freeShipping: true,
          discount: null,
          id: 'id',
          colors: 1,
        ),
      ]),
    );
    final response = await usecase();
    expect(response.isRight(), true);
  });
}
