import 'package:core/core.dart';

import 'parking_routes.dart';

class VehiclesRoutes {
  static BasePath root = BasePath('/vehicles/', ParkingRoutes.root);
  static BasePath addVehicle = BasePath('/add_vehicle/', root);
  static BasePath enterPlateNumber = BasePath(
    '/enter_plate_number/',
    root,
  );
}
