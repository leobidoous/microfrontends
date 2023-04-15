import 'package:core/core.dart';
import 'package:path/path.dart';

import '../../../domain/entities/ticket_window/unique_coupon_entity.dart';
import '../../../infra/datasources/ticket_window/i_ticket_window_datasource.dart';
import '../../../presentation/graphql/mutations/ticket_window_mutations.dart';

class TicketWindowDatasource extends ITicketWindowDatasource {
  final IGraphQlDriver graphQlClient;
  final IHttpDriver client;

  TicketWindowDatasource({
    required this.graphQlClient,
    required this.client,
  });

  @override
  Future<Either<Exception, Unit>> onOcrRecognizer() async {
    return Left(Exception());
  }

  @override
  Future<Either<List<GraphQLResponseError>, Unit>> uploadCoupon({
    required List<UniqueCouponEntity> coupons,
    required String customerId,
  }) async {
    /*
    final errors = List<GraphQLResponseError>.empty(growable: true);
    for (UniqueCouponEntity coupon in coupons) {
      final taxInvoice = await MultipartFile.fromPath(
        'taxInvoice',
        coupon.file.path,
        filename: '${coupon.key}_${basename(coupon.file.path)}',
      );
      final response = await graphQlClient.request(
        document: TicketWindowMutations.uploadCoupon,
        variables: {
          'taxInvoice': taxInvoice,
          'params': {'customerId': customerId},
        },
        operationName: 'ImportTaxInvoice',
        options: GraphQlDriverOptions(contentType: 'multipart/form-data'),
      );
      response.fold(
        (l) => errors.add(l),
        (r) async {
          try {
            final invoice = r.data['data']['importTaxInvoice'];
            final payment = (invoice as List).first;
            final response = await graphQlClient.request(
              document: TicketWindowMutations.updateCoupon,
              variables: {
                'id': payment['id'],
                'params': {
                  'total': NumberFormat.toCurrency(coupon.value, symbol: ''),
                  'customerId': customerId,
                  'status': 'PAID',
                },
              },
              operationName: 'UpdateTaxInvoice',
            );
            return response.fold((l) => errors.add(l), (r) => null);
          } catch (e) {
            return errors.add(GraphQLResponseError(message: e.toString()));
          }
        },
      );
    }
    if (errors.isNotEmpty) return Left(errors);
    return Right(unit);
    */
    final errors = List<GraphQLResponseError>.empty(growable: true);
    for (UniqueCouponEntity coupon in coupons) {
      // TODO: fix all graphql method to upload files and
      // stop use IHttpDriver to make this call
      String filename = basename(coupon.file.path);
      final taxInvoice = await MultipartFile.fromFile(
        coupon.file.path,
        filename: '${coupon.key}_$filename',
      );
      final data = FormData.fromMap({
        'variables': {
          'taxInvoice': 'taxInvoice',
          'params': {'customerId': customerId},
        },
        'query': TicketWindowMutations.uploadCoupon,
        'taxInvoice': taxInvoice,
      });
      final response = await client.post(
        DM.i.get<EnvironmentEntity>().endpointGraphql,
        data: data,
        options: HttpDriverOptions(
          accessToken: DM.i.get<SessionEntity>().token.accessToken,
        ),
      );
      response.fold(
        (l) => errors.add(
          GraphQLResponseError(message: l.statusMessage.toString()),
        ),
        (r) async {
          try {
            final response = await graphQlClient.request(
              data: GraphRequestData(
                document: TicketWindowMutations.updateCoupon,
                options: GraphQlDriverOptions(operationName: 'updateCoupon'),
                variables: {
                  'id': r
                      .data['data']['importTaxInvoice']['payments'].first['id'],
                  'params': {
                    'total': NumberFormat.toCurrency(coupon.value, symbol: ''),
                    'customerId': customerId,
                    'status': 'PAID',
                  },
                },
              ),
            );
            return response.fold((l) => errors.add(l), (r) => null);
          } catch (e) {
            return errors.add(GraphQLResponseError(message: e.toString()));
          }
        },
      );
    }

    if (errors.isNotEmpty) return Left(errors);
    return Right(unit);
  }
}
