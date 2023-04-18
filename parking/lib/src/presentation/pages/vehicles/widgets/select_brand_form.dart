part of '../add_vehicle_page.dart';

class _SelectBrandForm extends StatefulWidget {
  const _SelectBrandForm({super.key, required this.onContinue});
  final VoidCallback onContinue;

  @override
  State<_SelectBrandForm> createState() => _SelectBrandFormState();
}

class _SelectBrandFormState extends State<_SelectBrandForm> {
  final controller = DM.i.get<AddVehicleController>();
  final brandController = TextEditingController();
  List<BrandVehicleModel> filtredBrands = [];

  @override
  void initState() {
    super.initState();
    controller.searchBrands();
    filtredBrands = controller.brands;
  }

  void filterBrands(String brand) {
    filtredBrands = controller.brands
        .where(
          (element) => element.name!.toLowerCase().contains(
                brand.toLowerCase(),
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
                    Tr.of(context).whichBrand,
                    style: context.textTheme.titleMedium!.copyWith(
                      color: AppColorsBase.grey9,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GenInputField(
                  controller: brandController,
                  hintText: Tr.of(context).brand,
                  autofocus: false,
                  suffixIcon: (controller.selectedBrand != null)
                      ? Icon(
                          GenIcons.checkCircleOutline,
                          color: context.colorScheme.primary,
                        )
                      : null,
                  onChanged: (brand) {
                    setState(() {
                      filterBrands(brand!);
                      if (controller.selectedBrand?.name !=
                          brandController.text) {
                        controller.selectedBrand = null;
                      }
                    });
                  },
                ),
                if (filtredBrands.isNotEmpty &&
                    controller.selectedBrand == null) ...[
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
                        itemCount: filtredBrands.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 0.0,
                          indent: const Spacing(1).value,
                          endIndent: const Spacing(1).value,
                          color: context.colorScheme.tertiary.withOpacity(.16),
                        ),
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              filtredBrands[index].name ?? '',
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
                                  brandController.value =
                                      brandController.value.copyWith(
                                    text: filtredBrands[index].name!,
                                    selection: TextSelection.collapsed(
                                      offset: filtredBrands[index].name!.length,
                                    ),
                                  );
                                  controller.selectedBrand =
                                      filtredBrands[index];
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
              isEnabled: controller.selectedBrand != null,
              onPressed: widget.onContinue,
              text: 'Continuar',
            ),
          ),
        ),
      ],
    );
  }
}
