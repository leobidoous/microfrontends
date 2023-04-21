import 'package:core/core.dart';

import '../../../../parking.dart';
import '../../../domain/entities/dashboard/coupon_entity.dart';
import '../../../domain/entities/dashboard/ticket_entity.dart';
import '../../../domain/entities/ticket/ticket_payment_entity.dart';
import '../../../domain/entities/ticket/ticket_payment_request_entity.dart';
import '../../../domain/failures/dashboard/dashboard_failure.dart';
import '../../../infra/datasources/parking/i_parking_datasource.dart';
import '../../../infra/models/dashboard/coupon_model.dart';
import '../../../infra/models/dashboard/ticket_model.dart';
import '../../../infra/models/ticket/history_ticket_model.dart';
import '../../../infra/models/ticket/ticket_payment_model.dart';
import '../../../infra/models/ticket/ticket_payment_request_model.dart';

class ParkingDatasource implements IParkingDatasource {
  final String baseUrl;
  final IHttpDriver client;
  final IFirebaseStorageDriver storageDriver;

  ParkingDatasource({
    required this.baseUrl,
    required this.client,
    required this.storageDriver,
  });

  @override
  Future<Either<IParkingDashboardFailures, TicketEntity>> fecthInfoTicket({
    String? code,
    required String idShopping,
    required String customerId,
  }) async {
    final response = await client.get(
      '${baseUrl}ticket',
      queryParameters: {
        'id_mall': idShopping,
        'customer': customerId,
        if (code != null && code.isNotEmpty) 'code': code
      },
    );

    return response.fold(
      (l) {
        switch (l.statusCode) {
          case 404:
            return Left(
              NoTicketFoundError(
                'O cliente não possui ticket/placa associado ao dia atual.',
              ),
            );
          case 401:
            return Left(
              NoTicketFoundError(
                l.statusMessage!,
              ),
            );
          default:
            return Left(UnknowError(l.data));
        }
      },
      (r) {
        try {
          return Right(TicketModel.fromMap(r.data));
        } catch (e, s) {
          return Left(UnknowError('$e $s'));
        }
      },
    );
  }

  @override
  Future<Either<Exception, CouponEntity>> fetchCoupon({
    required String idShopping,
    required String customerId,
  }) async {
    final response = await client.get(
      '${baseUrl}parking/voucher/amount',
      queryParameters: {'customer': customerId, 'id_mall': idShopping},
    );
    return response.fold(
      (l) => Left(Exception(l.data)),
      (r) {
        try {
          return Right(CouponModel.fromMap(r.data));
        } catch (e, s) {
          return Left(Exception('$e $s'));
        }
      },
    );
  }

  @override
  Future<Either<IParkingDashboardFailures, TicketPaymentEntity>> paymentTicket({
    required TicketPaymentRequestEntity paymentRequestEntity,
  }) async {
    final response = await client.post(
      '${baseUrl}ticket',
      data: TicketPaymentRequestModel.fromEntity(paymentRequestEntity).toMap,
    );
    return response.fold(
      (l) {
        switch (l.statusCode) {
          case 404:
            return Left(
              NoTicketFoundError(
                l.statusCode.toString(),
                detailsMessage: l.data,
              ),
            );
          case 500:
            return Left(
              ServerError(l.statusCode.toString(), detailsMessage: l.data),
            );
          default:
            return Left(UnknowError(l.data));
        }
      },
      (r) {
        try {
          return Right(TicketPaymentModel.fromMap(r.data));
        } catch (e, s) {
          return Left(UnknowError('$e $s'));
        }
      },
    );
  }

  @override
  Future<Either<Exception, List<HistoryTicketModel>>> fetchHistoryTicket({
    required String page,
    required String perPage,
  }) async {
    final response = await client.get('${baseUrl}ticket/transactions/customer');

    return response.fold(
      (l) => Left(Exception(l.data)),
      (r) {
        try {
          final List<HistoryTicketModel> historys = r.data['rows']
              .map<HistoryTicketModel>(
                (element) => HistoryTicketModel.fromMap(element),
              )
              .toList();
          return Right(historys);
        } catch (e, s) {
          printException(exception: e, stackTrace: s);
          return Left(Exception(e));
        }
      },
    );
  }

  @override
  Future<Either<Exception, String>> fetchParkingRules({
    required String shoppingId,
  }) async {
    final response = await client.get(
      '${baseUrl}web/campaignFilter/',
      queryParameters: {'id_mall': shoppingId, 'type_campaign': 'Parking-Free'},
    );
    return response.fold(
      (l) => Left(Exception(l.data)),
      (r) {
        try {
          return Right((r.data['rows'] as List).first['regulation_link']);
        } catch (e) {
          return Left(Exception(e));
        }
      },
    );
  }
}
