import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/translations.dart';
import '../../../infra/models/vehicles/vehicle_model.dart';
import '../../controllers/parking/parking_enter_plate_number_controller.dart';
import '../../routes/parking_routes.dart';
import '../../routes/ticket_routes.dart';
import '../ticket/ticket_submit/ticket_submit_page.dart';
import 'widgets/shopping_location.dart';

class EnterPlateNumberPage extends StatefulWidget {
  const EnterPlateNumberPage({super.key});

  @override
  State<EnterPlateNumberPage> createState() => _EnterPlateNumberPageState();
}

class _EnterPlateNumberPageState extends State<EnterPlateNumberPage> {
  final controller = DM.i.get<ParkingEnterPlateNumberController>();

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
      appBar: CustomAppBar(
        title: 'Estacionamento',
        actions: [
          AppBarButton(
            onTap: DM.i.get<ZendeskController>().openChat,
            child: Icon(
              CoreIcons.contactUs,
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
            return const Center(child: CustomLoading());
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

  final controller = DM.i.get<ParkingEnterPlateNumberController>();
  final shopping = DM.i.get<ShoppingEntity>();
  final plateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<VehicleModel> vehicles;

  @override
  Widget build(BuildContext context) {
    return CustomScrollContent(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MallLocation(shopping: shopping),
          Spacing.sm.vertical,
          Text(
            Tr.of(context).registeredVehicle,
            textAlign: TextAlign.left,
            style: context.textTheme.bodyLarge?.copyWith(
              fontFamily: GoogleFonts.inter().fontFamily,
            ),
          ),
          Spacing.sm.vertical,
          SizedBox(
            height: const Spacing(7).value,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: const Spacing(2).value),
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
          Spacing.sm.vertical,
          CustomButton.text(
            text: Tr.of(context).continueButton,
            type: ButtonType.tertiary,
            onPressed: () {
              Nav.to.pushNamed(
                TicketRoutes.root,
                arguments: TicketSubmitPageArgs(
                  ticketOrPlate: controller.selectedPlate!.replaceAll('-', ''),
                  onPop: () {
                    Nav.to.popUntil(
                      ModalRoute.withName(ParkingRoutes.root.completePath),
                    );
                  },
                ),
              );
            },
          ),
          Spacing.sm.vertical,
          SizedBox(height: const Spacing(5).value),
          Spacing.sm.vertical,
          Text(
            Tr.of(context).haveAnotherVehicle,
            textAlign: TextAlign.left,
            style: context.textTheme.bodyLarge?.copyWith(
              fontFamily: GoogleFonts.inter().fontFamily,
            ),
          ),
          Spacing.sm.vertical,
          Form(
            key: formKey,
            child: CustomInputField(
              controller: plateController,
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
          Spacing.sm.vertical,
          CustomButton.text(
            text: Tr.of(context).continueButton,
            type: ButtonType.background,
            onPressed: () {
              if ((!(formKey.currentState?.validate() ?? false))) {
                return;
              }
              Nav.to.pushNamed(
                TicketRoutes.root,
                arguments: TicketSubmitPageArgs(
                  ticketOrPlate: plateController.text.replaceAll('-', ''),
                  onPop: () {
                    Nav.to.popUntil(
                      ModalRoute.withName(ParkingRoutes.root.completePath),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _NotHasVehicleRegistered extends StatelessWidget {
  final shopping = DM.i.get<ShoppingEntity>();
  final textController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomScrollContent(
      padding: EdgeInsets.all(const Spacing(3).value),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MallLocation(shopping: shopping),
          Spacing.sm.vertical,
          Text(
            Tr.of(context).validateParking,
            textAlign: TextAlign.left,
            style: context.textTheme.headlineSmall,
          ),
          Spacing.sm.vertical,
          Text(
            Tr.of(context).descriptionParking,
            textAlign: TextAlign.left,
            style: context.textTheme.bodySmall,
          ),
          Spacing.sm.vertical,
          Form(
            key: formKey,
            child: CustomInputField(
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
          Spacing.sm.vertical,
          CustomButton.text(
            text: Tr.of(context).continueButton,
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              if ((!(formKey.currentState?.validate() ?? false))) {
                return;
              }
              Nav.to.pushNamed(
                TicketRoutes.root,
                arguments: TicketSubmitPageArgs(
                  ticketOrPlate: textController.text.replaceAll('-', ''),
                  onPop: () {
                    Nav.to.popUntil(
                      ModalRoute.withName(ParkingRoutes.root.completePath),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
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
                CoreIcons.car,
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
