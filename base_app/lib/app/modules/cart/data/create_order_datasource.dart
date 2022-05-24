import 'package:core/core.dart';

import '../../../../core/constants/preferences_constants.dart';
import '../domain/entities/order_entity.dart';
import '../infra/datasources/create_order_datasource.dart';
import '../infra/models/order_model.dart';

class CreateOrderDatasource extends ICreateOrderDatasource {
  final IPreferencesStorageDriver storage;
  final IHttpDriver httpDriver;

  CreateOrderDatasource({
    required this.storage,
    required this.httpDriver,
  });

  @override
  Future<Either<Exception, Unit>> call({required OrderEntity order}) async {
    final response = await httpDriver.post(
      '/cart/',
      data: OrderModel.fromEntity(order).toMap(),
    );
    return response.fold(
      (l) => Left(l),
      (r) async {
        final response = await storage.getStringListByKey(
          key: PreferencesConstants.orders,
        );
        final orders = [OrderModel.fromEntity(order).toJson()];
        return response.fold(
          (l) => Left(l),
          (r) {
            orders.addAll(r);
            return storage.setStringListByKey(
              key: PreferencesConstants.orders,
              value: orders,
            );
          },
        );
      },
    );
  }
}
