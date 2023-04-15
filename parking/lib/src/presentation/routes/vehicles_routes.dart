import 'package:core/core.dart';

import 'parking_routes.dart';

class VehiclesRoutes {
  static const BasePath root = BasePath('/vehicles', ParkingRoutes.root);
  static const BasePath listVehicles = BasePath('/list_vehicle', root);
  static const BasePath addVehicle = BasePath('/add_vehicle', root);
}
