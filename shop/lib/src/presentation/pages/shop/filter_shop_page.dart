import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/store_brand_entity.dart';
import '../../../domain/entities/store_mall_entity.dart';
import '../../controllers/brands/fetch_store_brands_controller.dart';
import '../../controllers/dashboard_shop/fetch_store_malls_controller.dart';
import '../../controllers/dashboard_shop/filter_shop_controller.dart';
import '../../controllers/stores/fetch_stores_controller.dart';

class FilterShopPage extends StatefulWidget {
  const FilterShopPage({super.key});

  @override
  State<FilterShopPage> createState() => _FilterShopPageState();
}

class _FilterShopPageState extends State<FilterShopPage> {
  final storeBrandsController = DM.i.get<FetchStoreBrandsController>();
  final storeMallsController = DM.i.get<FetchStoreMallsController>();
  final storesController = DM.i.get<FetchStoresController>();
  final controller = DM.i.get<FilterShopController>();

  @override
  void initState() {
    super.initState();
    storeBrandsController.fetchStoreBrands();
    storeMallsController.fetchStoreMalls();
  }

  @override
  void dispose() {
    storeBrandsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsBase.neutrla0,
      appBar: CustomAppBar(
        leadingIcon: const Icon(CoreIcons.xmark),
        onBackTap: Nav.to.pop,
        title: 'Filtros',
        actions: [
          InkWell(
            onTap: () {
              controller.sortingFormKey.currentState!.reset();
              controller.brandsFormKey.currentState!.reset();
              controller.mallsFormKey.currentState!.reset();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: const Spacing(2).value,
                horizontal: const Spacing(4).value,
              ),
              child: Text(
                'Limpar',
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColorsBase.neutrla5,
                ),
              ),
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(const Spacing(3).value),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ordenar por',
              style: context.textTheme.bodyMedium!.copyWith(
                fontFamily: 'Poppins',
                fontWeight: AppFontWeight.medium.value,
                color: AppColorsBase.neutrla6,
              ),
            ),
            SizedBox(height: const Spacing(0.5).value),
            _DropDownSorting(
              options: const [
                'Mais relevantes',
                'Ordem alfabética',
              ],
              controller: controller,
            ),
            SizedBox(height: const Spacing(2).value),
            Divider(
              height: 1,
              color: AppColorsBase.neutrla1,
            ),
            SizedBox(height: const Spacing(2).value),
            Text(
              'Marca',
              style: context.textTheme.bodyMedium!.copyWith(
                fontFamily: 'Poppins',
                fontWeight: AppFontWeight.medium.value,
                color: AppColorsBase.neutrla6,
              ),
            ),
            SizedBox(height: const Spacing(0.5).value),
            ValueListenableBuilder<List<StoreBrandEntity>>(
              valueListenable: storeBrandsController,
              builder: (context, state, child) {
                if (storeBrandsController.isLoading) {
                  return _DropDownBrands(
                    brands: const <StoreBrandEntity>[],
                    controller: controller,
                  );
                }
                return _DropDownBrands(
                  brands: state,
                  controller: controller,
                );
              },
            ),
            SizedBox(height: const Spacing(2).value),
            Divider(
              height: 1,
              color: AppColorsBase.neutrla1,
            ),
            SizedBox(height: const Spacing(2).value),
            Text(
              'Empreendimento',
              style: context.textTheme.bodyMedium!.copyWith(
                fontFamily: 'Poppins',
                fontWeight: AppFontWeight.medium.value,
                color: AppColorsBase.neutrla6,
              ),
            ),
            SizedBox(height: const Spacing(0.5).value),
            ValueListenableBuilder<List<StoreMallEntity>>(
              valueListenable: storeMallsController,
              builder: (context, state, child) {
                if (storeMallsController.isLoading) {
                  return _DropDownMalls(
                    malls: const <StoreMallEntity>[],
                    controller: controller,
                  );
                }
                return _DropDownMalls(
                  malls: state,
                  controller: controller,
                );
              },
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: CustomButton.text(
                    type: ButtonType.primary,
                    text: 'Filtrar',
                    onPressed: () async {
                      var filters = controller.filterMap();
                      var orderBy = controller.orderByMap();

                      Nav.to.pop(
                        response: {
                          'filters': filters,
                          'pagination': orderBy,
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DropDownSorting extends StatelessWidget {
  const _DropDownSorting({
    required this.options,
    required this.controller,
  });

  final List<String> options;
  final FilterShopController controller;

  @override
  Widget build(BuildContext context) {
    return CustomDropdown(
      items: options,
      initialValue: 'Mais relevantes',
      callBack: (String value) {
        controller.option = value;
      },
      formKey: controller.sortingFormKey,
    );
  }
}

class _DropDownBrands extends StatelessWidget {
  const _DropDownBrands({required this.brands, required this.controller});
  final List<StoreBrandEntity> brands;
  final FilterShopController controller;

  @override
  Widget build(BuildContext context) {
    return CustomDropdown(
      items: brands.map((e) => e.name).toList(),
      hintText: 'Selecione a marca',
      callBack: (String value) {
        controller.brand = value;
      },
      formKey: controller.brandsFormKey,
    );
  }
}

class _DropDownMalls extends StatelessWidget {
  const _DropDownMalls({required this.malls, required this.controller});
  final List<StoreMallEntity> malls;
  final FilterShopController controller;

  @override
  Widget build(BuildContext context) {
    return CustomDropdown(
      items: malls.map((e) => e.name).toList(),
      hintText: 'Selecione um empreendimento',
      callBack: (String value) {
        controller.mall = value;
      },
      formKey: controller.mallsFormKey,
    );
  }
}
