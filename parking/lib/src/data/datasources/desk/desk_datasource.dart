import 'package:core/core.dart';

import '../../../domain/entities/desk/faq_entity.dart';
import '../../../domain/enums/desk_cart_status_enum.dart';
import '../../../infra/datasources/desk/i_desk_datasource.dart';
import '../../../infra/models/desk/faq_model.dart';

class DeskDatasource extends IDeskDatasource {
  DeskDatasource({
    required this.client,
    required this.baseUrl,
    required this.storageDriver,
  });

  final String baseUrl;
  final IHttpDriver client;
  final IFirebaseStorageDriver storageDriver;

  @override
  Future<Either<Exception, List<FAQEntity>>> fetchFAQs() async {
    final response = await LoadMock.fromAsset('faq_mock.json');
    return response.fold(
      (l) => Left(l),
      (r) {
        try {
          final faqs = (r['gen_desk'] as List)
              .map((faq) => FAQModel.fromMap(faq))
              .toList();
          return Right(faqs);
        } catch (e) {
          return Left(Exception(e));
        }
      },
    );
  }

  @override
  Future<Either<Exception, DeskCardStatus>> fetchParkingReleaseStatus() async {
    final response = await client.get('${baseUrl}parking/attempts/invoice');
    return response.fold(
      (l) => Left(Exception(l.data)),
      (r) {
        try {
          return Right(deskCardStatusFromJson(r.data['status']));
        } catch (e) {
          return Left(Exception(e));
        }
      },
    );
  }
}
