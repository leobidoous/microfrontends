import 'package:core/core.dart';

import '../../../domain/failures/vehicles/vehicle_failure.dart';
import '../../../domain/usecases/vehicles/i_vehicles_usecase.dart';
import '../../../infra/models/vehicles/add_vehicle_model.dart';
import '../../../infra/models/vehicles/brand_vehicle_model.dart';
import '../../../infra/models/vehicles/model_vehicle_model.dart';

class AddVehicleController
    extends GenController<IVehiclesFailures, AddVehicleModel> {
  AddVehicleController({required this.usecase})
      : super(AddVehicleModel.fromMap({}));
  final IVechicleUsecase usecase;

  final brands = <BrandVehicleModel>[];
  final models = <ModelVehicleModel>[];
  BrandVehicleModel? selectedBrand;
  ModelVehicleModel? selectedModel;

  Future<void> searchBrands() async {
    final currentBrands = await usecase.searchVehicleBrands().then(
          (value) => value.fold(
            (l) {
              // AppAssets.snackShowMessage(
              //   title: l.toString(),
              //   isError: true,
              // );
              return <BrandVehicleModel>[];
            },
            (r) => r,
          ),
        );
    brands
      ..clear()
      ..addAll(currentBrands);
  }

  Future<void> searchModel() async {
    final currentModel =
        await usecase.searchVehicleModels(idBrand: selectedBrand?.id ?? 0).then(
              (value) => value.fold(
                (l) {
                  // AppAssets.snackShowMessage(
                  //   title: l.toString(),
                  //   isError: true,
                  // );
                  return <ModelVehicleModel>[];
                },
                (r) => r,
              ),
            );
    models
      ..clear()
      ..addAll(currentModel);
  }

  Future<void> addVehicle({required String plate}) async {
    await execute(
      () => usecase
          .addVehicle(
            addVehicleEntity: AddVehicleModel(
              brandId: selectedBrand?.id,
              main: true,
              modelId: selectedModel?.id,
              plate: plate.replaceAll('-', ''),
            ),
          )
          .then(
            (value) => value.fold(
              (l) => Left(l),
              (r) => Right(r),
            ),
          ),
    );
  }
}
