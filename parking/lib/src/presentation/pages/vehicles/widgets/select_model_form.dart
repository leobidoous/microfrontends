part of '../add_vehicle_page.dart';

class _SelectModelForm extends StatefulWidget {
  const _SelectModelForm({super.key, required this.onContinue});
  final VoidCallback onContinue;

  @override
  State<_SelectModelForm> createState() => _SelectModelFormState();
}

class _SelectModelFormState extends State<_SelectModelForm> {
  final controller = DM.i.get<AddVehicleController>();
  final modelController = TextEditingController();
  List<ModelVehicleModel> filtredModels = [];

  @override
  void initState() {
    super.initState();
    controller.searchModel();
    filtredModels = controller.models;
  }

  void filterModels(String model) {
    filtredModels = controller.models
        .where(
          (element) => element.name!.toLowerCase().contains(
                model.toLowerCase(),
              ),
        )
        .toList();
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
                    Tr.of(context).whichModel,
                    style: context.textTheme.titleMedium!.copyWith(
                      color: AppColorsBase.grey9,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GenInputField(
                  controller: modelController,
                  hintText: Tr.of(context).model,
                  autofocus: false,
                  suffixIcon: (controller.selectedModel != null)
                      ? Icon(
                          CoreIcons.checkCircle,
                          color: context.colorScheme.primary,
                        )
                      : null,
                  onChanged: (model) {
                    setState(() {
                      filterModels(model!);
                      if (controller.selectedModel?.name !=
                          modelController.text) {
                        controller.selectedModel = null;
                      }
                    });
                  },
                ),
                if (filtredModels.isNotEmpty &&
                    controller.selectedModel == null) ...[
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.width / 2,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(const Spacing(1).value),
                        ),
                        border: Border.all(
                          color: AppColorsBase.grey7,
                          width: 1,
                        ),
                      ),
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: filtredModels.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 0.0,
                          indent: const Spacing(1).value,
                          endIndent: const Spacing(1).value,
                          color: context.colorScheme.tertiary.withOpacity(.16),
                        ),
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              filtredModels[index].name ?? '',
                              style: context.textTheme.bodyLarge?.copyWith(
                                fontFamily: GoogleFonts.inter().fontFamily,
                              ),
                            ),
                            splashColor:
                                context.colorScheme.onBackground.withOpacity(
                              .16,
                            ),
                            onTap: () {
                              setState(
                                () {
                                  modelController.value =
                                      modelController.value.copyWith(
                                    text: filtredModels[index].name!,
                                    selection: TextSelection.collapsed(
                                      offset: filtredModels[index].name!.length,
                                    ),
                                  );
                                  controller.selectedModel =
                                      filtredModels[index];
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: const Spacing(2).value,
              vertical: const Spacing(2).value,
            ),
            child: GenButton.text(
              isEnabled: controller.selectedModel != null,
              onPressed: widget.onContinue,
              text: 'Continuar',
            ),
          ),
        ),
      ],
    );
  }
}
