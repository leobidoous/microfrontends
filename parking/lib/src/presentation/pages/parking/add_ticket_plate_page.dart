import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/translations.dart';
import '../../../infra/models/vehicles/vehicle_model.dart';
import '../../controllers/parking/parking_add_plate_controller.dart';
import '../../routes/ticket_routes.dart';

class AddTicketPlatePage extends StatefulWidget {
  const AddTicketPlatePage({super.key});

  @override
  State<AddTicketPlatePage> createState() => _AddTicketPlatePageState();
}

class _AddTicketPlatePageState extends State<AddTicketPlatePage> {
  final controller = DM.i.get<ParkingAddPlateController>();

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
      appBar: GenAppBar(
        title: 'Estacionamento',
        showDivider: false,
        actions: [
          AppBarButton(
            onTap: () {},
            child: Icon(
              GenIcons.messageCircle,
              color: context.colorScheme.onBackground,
              size: const Spacing(3).value,
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder<List<VehicleModel>>(
        valueListenable: controller,
        builder: (context, state, child) {
          if (controller.isLoading) {
            return const Center(child: GenLoading());
          }
          if (state.isNotEmpty) {
            return _HasVehicleRegistered(
              vehicles: state,
            );
          }
          return _NotHasVehicleRegistered();
        },
      ),
    );
  }
}

class _HasVehicleRegistered extends StatelessWidget {
  _HasVehicleRegistered({required this.vehicles});
  final List<VehicleModel> vehicles;

  final controller = DM.i.get<ParkingAddPlateController>();
  final shopping = DM.i.get<ShoppingModel>();
  final textController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: const Spacing(2).value,
            ),
            child: _InfoLocationMall(
              name: shopping.name,
              address: shopping.address,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: const Spacing(3).value,
              right: const Spacing(2).value,
              left: const Spacing(2).value,
            ),
            child: Text(
              Tr.of(context).registeredVehicle,
              textAlign: TextAlign.left,
              style: context.textTheme.bodyLarge?.copyWith(
                fontFamily: GoogleFonts.inter().fontFamily,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: const Spacing(1).value),
            child: SizedBox(
              height: const Spacing(7).value,
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: const Spacing(2).value,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: vehicles.length,
                separatorBuilder: (context, index) => SizedBox(
                  width: const Spacing(1).value,
                ),
                itemBuilder: (context, index) {
                  return _VehicleCard(
                    brand: vehicles[index].vehicleBrand?.name ?? '',
                    model: vehicles[index].vehicleModel?.name ?? '',
                    plate: vehicles[index].plate ?? '',
                    isSelected: vehicles[index].main,
                    onTap: () {
                      controller.selectVehicle(
                        idVehicle: vehicles[index].id ?? 0,
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: const Spacing(3).value,
              right: const Spacing(3).value,
              left: const Spacing(3).value,
            ),
            child: GenButton.text(
              text: Tr.of(context).continueButton,
              type: ButtonType.tertiary,
              onPressed: () {
                Nav.to.pushNamed(
                  TicketRoutes.root,
                );
              },
            ),
          ),
          SizedBox(
            height: const Spacing(5).value,
          ),
          Divider(
            height: 0.0,
            color: AppColorsBase.neutrla1,
            indent: const Spacing(2).value,
            endIndent: const Spacing(2).value,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: const Spacing(6).value,
              right: const Spacing(2).value,
              left: const Spacing(2).value,
            ),
            child: Text(
              Tr.of(context).haveAnotherVehicle,
              textAlign: TextAlign.left,
              style: context.textTheme.bodyLarge?.copyWith(
                fontFamily: GoogleFonts.inter().fontFamily,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: const Spacing(2).value),
            child: Form(
              key: formKey,
              child: GenInputField(
                controller: textController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.characters,
                hintText: Tr.of(context).enterPlate,
                inputFormatters: [FormMasks.plate()],
                validators: [
                  FormValidators.emptyField,
                  (input) {
                    return FormValidators.invalidLength(input, 8);
                  }
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: const Spacing(3).value,
              right: const Spacing(2).value,
              left: const Spacing(2).value,
            ),
            child: GenButton.text(
              text: Tr.of(context).continueButton,
              type: ButtonType.background,
              onPressed: () {
                if ((!(formKey.currentState?.validate() ?? false))) {
                  return;
                }
                Nav.to.pushNamed(
                  TicketRoutes.root,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NotHasVehicleRegistered extends StatelessWidget {
  final shopping = DM.i.get<ShoppingModel>();
  final textController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: const Spacing(2).value,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _InfoLocationMall(
            name: shopping.name,
            address: shopping.address,
          ),
          Padding(
            padding: EdgeInsets.only(top: const Spacing(2.5).value),
            child: Text(
              Tr.of(context).validateParking,
              textAlign: TextAlign.left,
              style: context.textTheme.headlineSmall,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: const Spacing(1).value),
            child: Text(
              Tr.of(context).descriptionParking,
              textAlign: TextAlign.left,
              style: context.textTheme.bodySmall,
            ),
          ),
          Form(
            key: formKey,
            child: GenInputField(
              controller: textController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.characters,
              hintText: Tr.of(context).enterPlate,
              inputFormatters: [FormMasks.plate()],
              validators: [
                FormValidators.emptyField,
                (input) {
                  return FormValidators.invalidLength(input, 8);
                }
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: const Spacing(3).value),
            child: GenButton.text(
              text: Tr.of(context).continueButton,
              type: ButtonType.primary,
              onPressed: () {
                if ((!(formKey.currentState?.validate() ?? false))) {
                  return;
                }
                Nav.to.pushNamed(
                  TicketRoutes.root,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoLocationMall extends StatelessWidget {
  const _InfoLocationMall({required this.name, required this.address});

  final String name;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(GenIcons.locationPinAlt, color: AppColorsBase.grey6),
            Spacing.sm.horizontal,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    name,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onBackground,
                    ),
                  ),
                  Spacing.xxs.vertical,
                  Text(
                    address,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            top: const Spacing(2).value,
          ),
          child: Divider(
            endIndent: const Spacing(2).value,
            indent: const Spacing(2).value,
            height: 0.0,
            thickness: 1.0,
            color: context.colorScheme.shadow,
          ),
        ),
      ],
    );
  }
}

class _VehicleCard extends StatelessWidget {
  const _VehicleCard({
    required this.brand,
    required this.model,
    required this.plate,
    required this.onTap,
    this.isSelected = false,
  });

  final String brand;
  final String model;
  final String plate;
  final VoidCallback onTap;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
        side: BorderSide(
          width: 1.0,
          color:
              (isSelected!) ? context.colorScheme.primary : AppColorsBase.grey3,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.0),
        splashColor: context.colorScheme.shadow,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: const Spacing(2).value,
            horizontal: const Spacing(2).value,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                GenIcons.car,
                color: context.colorScheme.primary,
                size: 16.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: const Spacing(2).value),
                child: RichText(
                  text: TextSpan(
                    text: brand,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                    children: [
                      TextSpan(
                        text: '  Placa $plate $model',
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
