import 'package:core/core.dart';

import '../../../domain/entities/gen_desk/faq_entity.dart';
import '../../../domain/enums/desk_cart_status_enum.dart';
import '../../../infra/datasources/gen_desk/i_desk_datasource.dart';
import '../../../infra/models/gen_desk/faq_model.dart';

class DeskDatasource extends IDeskDatasource {
  final IFirebaseStorageDriver storageDriver;

  DeskDatasource({required this.storageDriver});

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
  Future<Either<Exception, DeskCardStatus>> fetchParkingReleaseStatus({
    required String customerId,
    required String marketplaceId,
  }) async {
    final collection =
        'marketplaces/$marketplaceId/customers/$customerId/parking';
    final response = await storageDriver.getCollection(
      filters: QuerySnapshotFiltersEntity(
        collection: collection,
        orderByField: 'updatedAt',
        limit: 1,
      ),
    );
    return response.fold(
      (l) => Left(l),
      (r) {
        try {
          if (r.docs.isEmpty) return Right(DeskCardStatus.initial);
          return Right(deskCardStatusFromJson(r.docs.first.data()['status']));
        } catch (e) {
          return Left(Exception(e));
        }
      },
    );
  }
}
