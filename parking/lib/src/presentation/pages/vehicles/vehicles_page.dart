import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/custom_assets.dart';
import '../../../../l10n/translations.dart';
import '../../../infra/models/vehicles/vehicle_model.dart';
import '../../controllers/vehicles/vehicle_list_controller.dart';
import '../../routes/vehicles_routes.dart';
import 'widgets/card_list_vehicle.dart';

part '../vehicles/widgets/empty_list_vehicle_page.dart';

class VehiclesPage extends StatefulWidget {
  const VehiclesPage({super.key});

  @override
  State<VehiclesPage> createState() => _VehiclesPageState();
}

class _VehiclesPageState extends State<VehiclesPage> {
  final controller = DM.i.get<VehicleListController>();

  @override
  void initState() {
    super.initState();
    controller.fetchVehicles();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      appBar: CustomAppBar(
        title: Tr.of(context).titleVehicle,
        showDivider: false,
        onBackTap: Nav.to.pop,
      ),
      body: ValueListenableBuilder<List<VehicleModel>>(
        valueListenable: controller,
        builder: (context, state, child) {
          if (controller.isLoading) {
            return const Center(
              child: CustomLoading(),
            );
          } else if (state.isEmpty) {
            return _EmptyListVehicleWidget(
              onTapAddVehicle: () =>
                  Nav.to.pushNamed(VehiclesRoutes.addVehicle.relativePath).then(
                        (_) => controller.fetchVehicles(),
                      ),
            );
          }
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: const Spacing(3).value,
              vertical: const Spacing(4).value,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Tr.of(context).seeAllVehicle,
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w300,
                    color: AppColorsBase.greyText02,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: const Spacing(4).value),
                  child: SizedBox(
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      itemCount: state.length,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => SizedBox(
                        height: const Spacing(1).value,
                      ),
                      itemBuilder: (context, index) {
                        return CardVehicle(
                          model: state[index].vehicleModel!.name!,
                          brand: state[index].vehicleBrand!.name!,
                          plate: state[index].plate!,
                          onPressed: () => showRemoveAlert(
                            model: state[index].vehicleModel!.name!,
                            brand: state[index].vehicleBrand!.name!,
                            plate: state[index].plate!,
                            id: state[index].id!,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: const Spacing(1).value),
                  child: InkWell(
                    highlightColor: context.colorScheme.primary.withOpacity(
                      .16,
                    ),
                    borderRadius: AppThemeBase.borderRadiusSM,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: const Spacing(1).value,
                        horizontal: const Spacing(1).value,
                      ),
                      child: Text(
                        Tr.of(context).addVehicle,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                    onTap: () => Nav.to
                        .pushNamed(VehiclesRoutes.addVehicle.relativePath)
                        .then(
                          (_) => controller.fetchVehicles(),
                        ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void showRemoveAlert({
    required String model,
    required String brand,
    required String plate,
    required int id,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: context.colorScheme.background,
          shape: RoundedRectangleBorder(
            borderRadius: AppThemeBase.borderRadiusLG,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: const Spacing(30).value,
                ),
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: Nav.to.pop,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(const Spacing(1).value),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.colorScheme.background,
                    border: Border.all(
                      color: context.colorScheme.primary,
                    ),
                    borderRadius: AppThemeBase.borderRadiusMD,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: const Spacing(3).value,
                        ),
                        child: Icon(
                          CoreIcons.carSide,
                          size: 26,
                          color: AppColorsBase.greyText01,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: const Spacing(2).value,
                            horizontal: const Spacing(3).value,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                brand,
                                style: context.textTheme.bodyLarge?.copyWith(
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                  color: context.colorScheme.onBackground,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: const Spacing(1).value,
                                ),
                                child: Text(
                                  model,
                                  softWrap: true,
                                  maxLines: 2,
                                  style: context.textTheme.bodySmall?.copyWith(
                                    color: AppColorsBase.greyText02,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                              Text(
                                'Placa $plate',
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: AppColorsBase.greyText02,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(const Spacing(1).value),
                child: Text(
                  Tr.of(context).removeVehicle,
                  style: context.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                Tr.of(context).actionCannotBeUndone,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColorsBase.greyText02,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: const Spacing(4).value,
                ),
                child: CustomButton.text(
                  text: Tr.of(context).yesRemov,
                  type: ButtonType.primary,
                  isSafe: true,
                  onPressed: () {
                    controller.removeVehicle(
                      idVehicle: id,
                    );
                    Nav.to.pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
