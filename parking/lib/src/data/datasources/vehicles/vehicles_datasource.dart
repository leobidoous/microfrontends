import 'dart:convert';

import 'package:core/core.dart';

import '../../../domain/failures/vehicles/vehicle_failure.dart';
import '../../../infra/datasources/vehicles/i_vehicles_datasource.dart';
import '../../../infra/models/vehicles/add_vehicle_model.dart';

class VehiclesDatasource extends IVehiclesDatasource {
  VehiclesDatasource({
    required this.client,
    required this.baseUrl,
  });
  final IHttpDriver client;
  final String baseUrl;

  @override
  Future<Either<Exception, List<Map<String, dynamic>>>> fetchVehicles() async {
    final path = '${baseUrl}vehicle';
    final response = await client.get(path);

    return response.fold(
      (l) => Left(Exception(l.data)),
      (r) => Right(List<Map<String, dynamic>>.from(r.data)),
    );
  }

  @override
  Future<Either<Exception, Map<String, dynamic>>> removeVehicle({
    required int idVehicle,
  }) async {
    final path = '${baseUrl}vehicle/$idVehicle';
    final response = await client.delete(path);

    return response.fold(
      (l) => Left(Exception(l.data)),
      (r) => Right(r.data),
    );
  }

  @override
  Future<Either<IVehiclesFailures, List<Map<String, dynamic>>>>
      searchVehicleBrands() async {
    final path = '${baseUrl}vehicle/brand';
    final response = await client.get(path);

    return response.fold(
      (l) {
        switch (l.statusCode) {
          case 400:
            return Left(SomeWrongInformationFailure());
          case 401:
            return Left(WrongTokenFailure());
          case 404:
            return Left(NotFoundModelFailure());
          default:
            return Left(UnknowFailure());
        }
      },
      (r) => Right(List<Map<String, dynamic>>.from(r.data)),
    );
  }

  @override
  Future<Either<IVehiclesFailures, List<Map<String, dynamic>>>>
      searchVehicleModels({
    required int idBrand,
  }) async {
    final path = '${baseUrl}vehicle/brand/$idBrand/model';
    final response = await client.get(path);
    return response.fold(
      (l) {
        switch (l.statusCode) {
          case 400:
            return Left(SomeWrongInformationFailure());
          case 401:
            return Left(WrongTokenFailure());
          case 404:
            return Left(NotFoundModelFailure());
          default:
            return Left(UnknowFailure());
        }
      },
      (r) => Right(List<Map<String, dynamic>>.from(r.data)),
    );
  }

  @override
  Future<Either<IVehiclesFailures, Map<String, dynamic>>> addVehicle({
    AddVehicleModel? addVehicleEntity,
  }) async {
    final path = '${baseUrl}vehicle';
    final response = await client.post(
      path,
      data: addVehicleEntity?.toJson,
    );

    return response.fold(
      (l) {
        final error = json.decode(l.data);
        switch (l.statusCode) {
          case 400:
            return Left(
              SomeWrongInformationFailure(
                detailsMessage: (error is Map) ? error['message'] : null,
              ),
            );
          case 401:
            return Left(WrongTokenFailure());
          case 404:
            return Left(NotFoundModelFailure());
          default:
            return Left(UnknowFailure());
        }
      },
      (r) => Right(r.data),
    );
  }
}
