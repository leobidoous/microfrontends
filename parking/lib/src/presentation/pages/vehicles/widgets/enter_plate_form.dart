part of '../add_vehicle_page.dart';

class _EnterPlateForm extends StatefulWidget {
  const _EnterPlateForm();

  @override
  State<_EnterPlateForm> createState() => __EnterPLaStalateForm();
}

class __EnterPLaStalateForm extends State<_EnterPlateForm> {
  final controller = DM.i.get<AddVehicleController>();
  final plateController = TextEditingController();
  final formKey = const GlobalObjectKey<FormState>('key');
  final streamButton = StreamController<bool>();

  @override
  void dispose() {
    streamButton.close();
    plateController.dispose();
    super.dispose();
  }

  void validateForm() {
    streamButton.add((formKey.currentState?.validate() ?? false));
  }

  void createVehicle() async {
    FocusScope.of(context).requestFocus(FocusNode());
    controller
        .addVehicle(
      plate: plateController.text.toUpperCase(),
    )
        .then((value) async {
      if (controller.hasError) {
        switch (controller.error.runtimeType) {
          case SomeWrongInformationFailure:
            GenDialog.show(
              context,
              GenAlert.vehicleRegisterFailure(
                context,
                description: controller.error?.message,
              ),
              showClose: true,
            );
            break;
          case WrongTokenFailure:
            GenDialog.show(
              context,
              GenAlert.vehicleRegisterFailure(
                context,
                description: controller.error?.message ??
                    'O token fornecido não possui autorização.',
              ),
              showClose: true,
            );
            break;
          case NotFoundModelFailure:
            GenDialog.show(
              context,
              GenAlert.vehicleRegisterFailure(
                context,
                description:
                    controller.error?.message ?? 'O modelo não foi encontrado.',
              ),
              showClose: true,
            );
            break;
          default:
            GenDialog.show(
              context,
              GenAlert.vehicleRegisterFailure(
                context,
                description:
                    controller.error?.message ?? 'Houve um error desconhecido',
              ),
              showClose: true,
            );
            break;
        }
      } else {
        await GenDialog.show(
          context,
          GenAlert.vehicleRegisterSuccess(context),
          showClose: true,
        ).then(
          (_) => Nav.to.popUntil(
            ModalRoute.withName(VehiclesRoutes.root.completePath),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: GenScrollContent(
            padding: EdgeInsets.fromLTRB(
              const Spacing(2).value,
              const Spacing(2).value,
              const Spacing(2).value,
              Spacing.orKeyboardPadding(context, const Spacing(2).value),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  Tr.of(context).registerVehicle,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColorsBase.greyText01,
                    fontFamily: GoogleFonts.inter().fontFamily,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: const Spacing(4).value,
                  ),
                  child: Text(
                    Tr.of(context).whichPlate,
                    style: context.textTheme.titleMedium!.copyWith(
                      color: AppColorsBase.grey9,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Form(
                  key: formKey,
                  child: GenInputField(
                    controller: plateController,
                    hintText: Tr.of(context).plate,
                    autofocus: false,
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters: [FormMasks.plate()],
                    validators: [
                      FormValidators.emptyField,
                      (input) {
                        return FormValidators.invalidLength(input, 8);
                      }
                    ],
                    onChanged: (_) {
                      validateForm();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        ValueListenableBuilder<AddVehicleModel>(
          valueListenable: controller,
          builder: (context, value, child) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: const Spacing(2).value,
                  vertical: const Spacing(2).value,
                ),
                child: StreamBuilder<bool>(
                  stream: stream,
                  initialData: false,
                  builder: (context, snapshot) => GenButton.text(
                    isEnabled: snapshot.data!,
                    isLoading: controller.isLoading,
                    type: ButtonType.tertiary,
                    onPressed: createVehicle,
                    text: 'Continuar',
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Stream<bool> get stream => streamButton.stream;
}
