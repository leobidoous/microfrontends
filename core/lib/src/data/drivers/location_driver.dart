import 'package:geolocator/geolocator.dart';

import '../../domain/entities/position_entity.dart';
import '../../domain/interfaces/either.dart';
import '../../infra/drivers/i_location_driver.dart';

class LocationDriver extends ILocationDriver {
  @override
  Future<Either<Exception, PositionEntity>> getCurrentPosition() async {
    try {
      final response = await Geolocator.getCurrentPosition();
      return Right(
        PositionEntity(
          latitude: response.latitude,
          longitude: response.longitude,
        ),
      );
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, double>> getDistanceBetween({
    required double latitude,
    required double longitude,
  }) async {
    final response = await getCurrentPosition();
    return response.fold((l) => Left(l), (position) async {
      try {
        final response = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          latitude,
          longitude,
        );
        return Right(response);
      } catch (e) {
        return Left(Exception(e));
      }
    });
  }
}
