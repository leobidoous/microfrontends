import 'dart:async';

import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/translations.dart';
import '../../../domain/failures/vehicles/vehicle_failure.dart';
import '../../../infra/models/vehicles/add_vehicle_model.dart';
import '../../../infra/models/vehicles/brand_vehicle_model.dart';
import '../../../infra/models/vehicles/model_vehicle_model.dart';
import '../../controllers/vehicles/add_vehicle_controller.dart';
import '../../routes/vehicles_routes.dart';

part 'widgets/select_brand_form.dart';
part 'widgets/select_model_form.dart';
part 'widgets/enter_plate_form.dart';

enum PagesType { selectBrand, selectModel, enterPlate }

class AddVehiclePage extends StatefulWidget {
  const AddVehiclePage({super.key});

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  final controller = DM.i.get<AddVehicleController>();
  final pageController = PageController(
    initialPage: PagesType.values.first.index,
  );
  final brands = <BrandVehicleModel>[];
  int currentPage = PagesType.values.first.index;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void nextPageView() {
    currentPage++;
    FocusManager.instance.primaryFocus?.unfocus();
    pageController.animateToPage(
      currentPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.decelerate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenAppBar(
        title: Tr.of(context).vehicleRegistration,
        onBackTap: () {
          if (currentPage == PagesType.selectBrand.index) {
            Nav.to.pop();
          } else {
            currentPage--;
            pageController.animateToPage(
              currentPage,
              duration: const Duration(milliseconds: 500),
              curve: Curves.decelerate,
            );
          }
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _SelectBrandForm(
                  key: const ValueKey(1),
                  onContinue: nextPageView,
                ),
                _SelectModelForm(
                  key: const ValueKey(2),
                  onContinue: nextPageView,
                ),
                const _EnterPlateForm(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
