import '../../domain/entities/postal_code_entity.dart';
import '../../domain/interfaces/either.dart';
import '../../infra/datasources/i_search_postal_code_datasource.dart';
import '../../infra/drivers/i_http_driver.dart';
import '../../infra/models/postal_code_model.dart';

class SearchPostalCodeDatasource extends ISearchPostalCodeDatasource {
  final IHttpDriver client;

  SearchPostalCodeDatasource({required this.client});

  @override
  Future<Either<Exception, PostalCodeEntity>> call({
    required String postalCode,
  }) async {
    final code = postalCode.replaceAll(RegExp(r'[^0-9]'), '');
    final response = await client.get('https://viacep.com.br/ws/$code/json/');
    return response.fold(
      (l) => Left(Exception(l.statusMessage)),
      (r) {
        try {
          if (r.data['cep'] == null) throw Exception();
          return Right(PostalCodeModel.fromMap(r.data));
        } catch (e, s) {
          return Left(Exception('$e $s'));
        }
      },
    );
  }
}
