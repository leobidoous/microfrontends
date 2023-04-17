import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../domain/failures/coupon/coupon_failure.dart';
import '../../controllers/coupon/coupon_submit_controller.dart';
import '../../controllers/parking/parking_controller.dart';
import '../../routes/coupon_routes.dart';
import 'coupon_successfully_registered_page.dart';
import 'widgets/coupon_already_registered_error_view.dart';
import 'widgets/search_place_error_view.dart';

class CouponSubmitPage extends StatefulWidget {
  const CouponSubmitPage({super.key, required this.qrcode});

  final String qrcode;

  @override
  State<CouponSubmitPage> createState() => _CouponSubmitPageState();
}

class _CouponSubmitPageState extends State<CouponSubmitPage> {
  final couponController = DM.i.get<ParkingController>().couponController;
  final controller = DM.i.get<CouponSubmitController>();
  final shopping = DM.i.get<ShoppingEntity>();

  @override
  void initState() {
    super.initState();
    registerCoupon();
  }

  void registerCoupon() {
    controller
        .onRegisterCoupon(
      qrcode: widget.qrcode,
      idShopping: shopping.id.toString(),
    )
        .then((value) async {
      if (controller.error is InvalidCodeError ||
          controller.error is KeyNotInformedError ||
          controller.error is CouponQueryError) {
        await GenDialog.show(
          context,
          GenAlert.couponReadingError(context),
          showClose: true,
        );
        Nav.to.pop(response: controller.error);
      } else if (!controller.hasError) {
        Nav.to.pop();
        await Nav.to.pushReplacementNamed(
          CouponRoutes.couponSuccessfullyRegistered,
          arguments: CouponSuccessfullyRegisteredPageArgs(
            coupon: controller.coupon!,
            transaction: controller.state,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Nav.to.pop(response: controller.error);
        return false;
      },
      child: ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, value, child) {
          if (controller.isLoading) {
            return Scaffold(
              appBar: GenAppBar(
                title: 'Cupom Fiscal',
                actions: [
                  AppBarButton(
                    child: Icon(
                      GenIcons.messageCircle,
                      color: context.colorScheme.onBackground,
                    ),
                    onTap: () => DM.i.get<ZendeskController>().openChat(),
                  ),
                ],
              ),
              body: const Center(child: GenLoading()),
            );
          } else if (controller.hasError) {
            if (controller.error is CouponAlreadyRegisteredError) {
              return CouponAlreadyRegisteredErrorView(
                error: controller.error!,
                parkingRoleUrl: couponController.parkingRoleUrl,
              );
            } else if (controller.error is PlaceNotFoundError) {
              return SearchPlaceErrorView(error: controller.error!);
            }
            return Scaffold(
              appBar: GenAppBar(
                title: 'Cupom Fiscal',
                actions: [
                  AppBarButton(
                    child: Icon(
                      GenIcons.messageCircle,
                      color: context.colorScheme.onBackground,
                    ),
                    onTap: () => DM.i.get<ZendeskController>().openChat(),
                  ),
                ],
              ),
              body: Center(
                child: RequestError(
                  padding: EdgeInsets.all(const Spacing(2).value),
                  message:
                      controller.error?.message ?? controller.error.toString(),
                  onPressed: registerCoupon,
                ),
              ),
            );
          }
          return Scaffold(
            appBar: GenAppBar(
              title: 'Cupom Fiscal',
              actions: [
                AppBarButton(
                  child: Icon(
                    GenIcons.messageCircle,
                    color: context.colorScheme.onBackground,
                  ),
                  onTap: () => DM.i.get<ZendeskController>().openChat(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
