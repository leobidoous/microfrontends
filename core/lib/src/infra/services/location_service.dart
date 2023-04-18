import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import '../../domain/interfaces/either.dart';
import '../../domain/services/i_location_service.dart';

class LocationService extends ILocationService {
  @override
  Future<Either<Exception, Unit>> init() async {
    try {
      await Geolocator.isLocationServiceEnabled();
      debugPrint('LocationService iniciado com sucesso.');
      return Right(unit);
    } catch (e) {
      debugPrint('Erro ao inicializar LocationService.');
      return Left(Exception(e));
    }
  }
}
