import 'package:core/core.dart';

import '../../../domain/usecases/vehicles/i_vehicles_usecase.dart';
import '../../../infra/models/vehicles/vehicle_model.dart';

class ParkingAddPlateController
    extends GenController<Exception, List<VehicleModel>> {
  ParkingAddPlateController({
    required this.useCase,
  }) : super([]);

  final IVechicleUsecase useCase;
  final vehicles = <VehicleModel>[];
  String? selectedPlate;

  Future<void> fetchVehicles() async {
    await execute(() {
      return useCase.fetchVehicles().then(
            (value) => value.fold((l) => Left(l), (r) {
              vehicles
                ..clear()
                ..addAll(r);
              selectedPlate = vehicles.firstWhere((e) => e.main == true).plate;
              return Right(r);
            }),
          );
    });
  }

  Future<void> selectVehicle({required int idVehicle}) async {
    final updateVehicles = vehicles.map<VehicleModel>((element) {
      if (element.main == true && element.id != idVehicle) {
        return element.copyWith(
          main: false,
        );
      } else if (element.id == idVehicle) {
        selectedPlate = element.plate;
        return element.copyWith(
          main: true,
        );
      }
      return element;
    }).toList();
    vehicles
      ..clear()
      ..addAll(updateVehicles);

    await update(updateVehicles);
  }
}
