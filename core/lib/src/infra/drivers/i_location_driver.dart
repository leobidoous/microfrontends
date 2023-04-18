import '../../domain/entities/position_entity.dart';
import '../../domain/interfaces/either.dart';

abstract class ILocationDriver {
  Future<Either<Exception, PositionEntity>> getCurrentPosition();
  Future<Either<Exception, double>> getDistanceBetween({
    required double latitude,
    required double longitude,
  });
}
