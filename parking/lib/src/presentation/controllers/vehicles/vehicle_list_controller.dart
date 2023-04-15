import 'package:core/core.dart';

import '../../../domain/usecases/vehicles/i_vehicles_usecase.dart';
import '../../../infra/models/vehicles/vehicle_model.dart';

class VehicleListController
    extends GenController<Exception, List<VehicleModel>> {
  VehicleListController({required this.usecase}) : super([]);
  final IVechicleUsecase usecase;
  final vehicles = <VehicleModel>[];

  Future<void> fetchVehicles() async {
    await execute(() async {
      final result = await usecase.fetchVehicles();
      return result.fold((l) => Left(l), (r) {
        vehicles
          ..clear()
          ..addAll(r);
        return Right(vehicles);
      });
    });
  }

  Future<void> removeVehicle({required int idVehicle}) async {
    vehicles.removeWhere((element) => element.id == idVehicle);
    update(vehicles, force: true);
    usecase.removeVehicle(idVehicle: idVehicle).then((value) {
      return value.fold(
        (l) {
          // AppAssets.snackShowMessage(
          //   title: 'Não foi possível remover o veículo.',
          //   isError: true,
          // );
          return l;
        },
        (r) {
          // AppAssets.snackShowMessage(
          //   title: 'Veículo excluído com sucesso!',
          //   isError: false,
          // );
          return;
        },
      );
    });
  }
}
