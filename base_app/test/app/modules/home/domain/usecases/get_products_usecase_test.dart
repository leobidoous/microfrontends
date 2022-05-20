import 'package:base_app/app/modules/home/domain/entities/product_entity.dart';
import 'package:base_app/app/modules/home/domain/entities/search_products_filters_entity.dart';
import 'package:base_app/app/modules/home/domain/repositories/get_products_repository.dart';
import 'package:base_app/app/modules/home/domain/usecases/get_products_usecase.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_products_usecase_test.mocks.dart';

@GenerateMocks([IGetProductsRepository])
void main() {
  final repositoryMock = MockIGetProductsRepository();

  test('Deve retornar uma lista de ProductEntity', () async {
    final usecase = GetProductsUsecase(repository: repositoryMock);
    final params = SearchProductsFiltersEntity(q: ' ');
    when(usecase(params: params)).thenAnswer(
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
    final response = await usecase(params: params);
    expect(response.isRight(), true);
  });

  test('Deve retornar um erro se o parametro de busca for vazio', () async {
    final usecase = GetProductsUsecase(repository: repositoryMock);
    final params = SearchProductsFiltersEntity();
    final response = await usecase(params: params);
    expect(response.isLeft(), true);
  });
}
