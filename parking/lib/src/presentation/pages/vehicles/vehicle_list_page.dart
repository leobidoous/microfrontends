import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../../../infra/models/vehicles/vehicle_model.dart';
import '../../controllers/vehicles/vehicle_list_controller.dart';
import '../../routes/vehicles_routes.dart';
import 'widgets/card_list_vehicle.dart';

part '../vehicles/widgets/empty_list_vehicle_page.dart';

class VehicleListPage extends StatefulWidget {
  const VehicleListPage({super.key});

  @override
  State<VehicleListPage> createState() => _VehicleListPageState();
}

class _VehicleListPageState extends State<VehicleListPage> {
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
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: context.colorScheme.background,
      appBar: GenAppBar(
        title: ParkingLabels.titleVehicle,
        showDivider: false,
        onBackTap: Nav.to.pop,
      ),
      body: ValueListenableBuilder<List<VehicleModel>>(
        valueListenable: controller,
        builder: (context, state, child) {
          if (controller.isLoading) {
            return const Center(
              child: GenLoading(),
            );
          } else if (state.isEmpty) {
            return _EmptyListVehicleWidget(
              onTapAddVehicle: () {
                Nav.to
                    .pushNamed(
                      VehiclesRoutes.addVehicle,
                      arguments: true,
                    )
                    .then(
                      (value) => controller.fetchVehicles(),
                    );
              },
            );
          } else {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: GenMeasures.base * 1.5,
                vertical: GenMeasures.base * 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: ParkingLabels.seeAllVehicles,
                      style: context.textTheme.headlineSmall!
                          .copyWith(color: GenColors.gray),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: GenMeasures.base * 2),
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
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    surfaceTintColor: AppColorsBase.kWhite,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          GenMeasures.borderRadius * 4,
                                        ),
                                      ),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: GenMeasures.base * 15,
                                          ),
                                          child: IconButton(
                                            icon: const Icon(Icons.close),
                                            onPressed: Nav.to.pop,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: AppColorsBase.kWhite,
                                              border: Border.all(
                                                color:
                                                    context.colorScheme.primary,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(
                                                  GenMeasures.borderRadius,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        const Spacing(3).value,
                                                  ),
                                                  child: Icon(
                                                    GenIcons.carSide,
                                                    size: 26,
                                                    color: AppColorsBase
                                                        .greyText01,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                  child: VerticalDivider(
                                                    width: 1,
                                                    thickness: 2,
                                                    color: AppColorsBase.grey2,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        const Spacing(2).value,
                                                    horizontal:
                                                        const Spacing(3).value,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        state[index]
                                                            .vehicleBrand!
                                                            .name!,
                                                        style: theme.bodyLarge
                                                            ?.copyWith(
                                                          fontFamily:
                                                              GoogleFonts
                                                                      .inter()
                                                                  .fontFamily,
                                                          color: AppColorsBase
                                                              .primary10Color,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          vertical:
                                                              const Spacing(1)
                                                                  .value,
                                                        ),
                                                        child: Text(
                                                          state[index]
                                                              .vehicleModel!
                                                              .name!,
                                                          style: theme.bodySmall
                                                              ?.copyWith(
                                                            color: AppColorsBase
                                                                .greyText02,
                                                            fontWeight:
                                                                FontWeight.w200,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Placa ${state[index].plate}',
                                                        style: theme.bodySmall
                                                            ?.copyWith(
                                                          color: AppColorsBase
                                                              .greyText02,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            ParkingLabels.removeVehicle,
                                            style: context.textTheme.titleLarge,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Text(
                                          ParkingLabels.actionCannotBeUndone,
                                          style: context.textTheme.titleMedium!
                                              .copyWith(
                                            color: GenColors.gray,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      ButtonWidget(
                                        text: ParkingLabels.yesRemove,
                                        onPressed: () {
                                          controller.removeVehicle(
                                            idVehicle: state[index].id!,
                                          );
                                          Nav.to.pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  BasicTextButtonWidget(
                    text: ParkingLabels.addVehicle,
                    color: GenColors.primary,
                    onPressed: () {
                      Nav.to
                          .pushNamed(
                            VehiclesRoutes.addVehicle,
                            arguments: true,
                          )
                          .then(
                            (value) => controller.fetchVehicles(),
                          );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
