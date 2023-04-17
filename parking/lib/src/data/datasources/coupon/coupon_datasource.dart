import 'package:core/core.dart';
import 'package:wallet/wallet.dart';

import '../../../domain/enums/desk_cart_status_enum.dart';
import '../../../infra/datasources/coupon/i_coupon_datasource.dart';

class CouponDatasource extends ICouponDatasource {
  CouponDatasource({
    required this.client,
    required this.baseUrl,
    required this.storageDriver,
  });

  final String baseUrl;
  final IHttpDriver client;
  final IFirebaseStorageDriver storageDriver;

  @override
  Future<Either<Exception, List<TransactionEntity>>> fetchCoupons({
    required String customerId,
    required String marketplaceId,
  }) async {
    final collection =
        'marketplaces/$marketplaceId/customers/$customerId/payments';
    final response = await storageDriver.getCollection(
      filters: QuerySnapshotFiltersEntity(
        orderDescending: true,
        collection: collection,
        orderByField: 'updatedAt',
        whereFieldIsEqualTo: {
          'paymentProcessor': 'nf_import',
        },
        whereFieldIn: {
          'method': ['MONEY_EXTERNAL', 'DEBIT_EXTERNAL'],
        },
      ),
    );
    return response.fold(
      (l) => Left(l),
      (r) {
        try {
          final transactions = List<TransactionEntity>.empty(growable: true);
          r.docs.forEach((e) {
            transactions.add(TransactionModel.fromMap(e.data()));
          });
          return Right(transactions);
        } catch (e, s) {
          return Left(Exception('$e $s'));
        }
      },
    );
  }

  @override
  Future<Either<CloudFunctionDriverResponse, TransactionEntity>>
      onRegisterCoupon({
    required String customerId,
    required String qrcode,
  }) async {
    final response = await storageDriver.cloudFunction(
      name: 'getTaxInvoices',
      data: {'qrcode': qrcode, 'customerId': customerId},
    );
    return response.fold(
      (l) => Left(l),
      (r) {
        try {
          return Right(TransactionModel.fromMap(Map.from(r.data['body'])));
        } catch (e) {
          return Left(
            CloudFunctionDriverResponse(data: e),
          );
        }
      },
    );
  }

  @override
  Future<Either<Exception, Object>> onValidateCoupon() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, Unit>> setParkingReleaseStatus({
    required DeskCardStatus status,
  }) async {
    final response = await client.post(
      '${baseUrl}parking/attempts/invoice',
      data: {'status': status.toJson},
    );
    return response.fold(
      (l) => Left(Exception(l.data)),
      (r) {
        try {
          return Right(unit);
        } catch (e) {
          return Left(Exception(e));
        }
      },
    );
  }
}
