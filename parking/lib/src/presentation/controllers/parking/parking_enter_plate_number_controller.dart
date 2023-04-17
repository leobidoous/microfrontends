import 'package:core/core.dart';

import '../../../domain/usecases/vehicles/i_vehicles_usecase.dart';
import '../../../infra/models/vehicles/vehicle_model.dart';

class ParkingEnterPlateNumberController
    extends GenController<Exception, List<VehicleModel>> {
  ParkingEnterPlateNumberController({
    required this.usecase,
  }) : super([]);

  final IVechicleUsecase usecase;
  String? selectedPlate;

  Future<void> fetchVehicles() async {
    await execute(() {
      return usecase.fetchVehicles().then(
            (value) => value.fold((l) => Left(l), (r) {
              selectedPlate = r.firstWhere((e) => e.main == true).plate;
              return Right(r);
            }),
          );
    });
  }

  Future<void> selectVehicle({required int idVehicle}) async {
    final updateVehicles = state.map<VehicleModel>((element) {
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

    await update(updateVehicles);
  }
}
