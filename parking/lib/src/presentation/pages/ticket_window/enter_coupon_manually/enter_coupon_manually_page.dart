import 'dart:io';

import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/ticket_window/unique_coupon_entity.dart';
import '../../../controllers/ticket_window/enter_coupon_manually_controller.dart';
import '../../../controllers/ticket_window/review_photos_controller.dart';
import '../../../routes/ticket_window_routes.dart';
import 'widgets/coupon_list_item.dart';

class EnterCouponManuallyPage extends StatefulWidget {
  const EnterCouponManuallyPage({super.key, required this.files});

  final List<File> files;

  @override
  State<EnterCouponManuallyPage> createState() =>
      _EnterCouponManuallyPageState();
}

class _EnterCouponManuallyPageState extends State<EnterCouponManuallyPage> {
  final controller = DM.i.get<EnterCouponManuallyController>();
  final reviewController = DM.i.get<ReviewPhotosController>();
  final formKey = GlobalKey<FormState>();
  final scrollController = ScrollController();
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.files.forEach((e) {
      controller.onAddValue(
        UniqueCouponEntity(
          key: UniqueKey().toString(),
          file: e,
        ),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenAppBar(title: 'Registro de cupom'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(const Spacing(2).value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Informe os valores',
                style: context.textTheme.titleMedium,
              ),
              Spacing.sm.vertical,
              Expanded(child: _inputedValues),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _inputedValues {
    return ValueListenableBuilder<List<UniqueCouponEntity>>(
      valueListenable: controller,
      builder: (context, state, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: state.length,
                padding: EdgeInsets.zero,
                controller: scrollController,
                separatorBuilder: (_, __) => Spacing.sm.vertical,
                itemBuilder: (_, index) => CouponListItem(
                  coupon: state[index],
                  onUpdateValue: (value) {
                    controller.onUpdateCouponValue(value, state[index]);
                  },
                ),
              ),
            ),
            Spacing.lg.vertical,
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: 'Total de ',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: context.textTheme.fontWeightLight,
                ),
                children: [
                  TextSpan(
                    text: controller.state.length != 1
                        ? '${controller.state.length} cupons '
                        : '${controller.state.length} cupom ',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: context.textTheme.fontWeightMedium,
                    ),
                  ),
                  const TextSpan(text: 'no valor de '),
                  TextSpan(
                    text: NumberFormat.toCurrency(controller.sum),
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: context.textTheme.fontWeightMedium,
                    ),
                  ),
                ],
              ),
            ),
            Spacing.lg.vertical,
            GenButton.text(
              onPressed: () {
                controller.uploadCoupons().then((value) {
                  if (controller.hasError) {
                    GenDialog.show(context, GenAlert.serverError(context));
                    return;
                  }
                  reviewController.onClear();
                  Nav.to.pushNamed(
                    TicketWindowRoutes.couponSubmissionResult.relativePath,
                  );
                });
              },
              isLoading: controller.isLoading,
              text: 'Confirmar valor',
              isEnabled: controller.isValid,
              type: ButtonType.tertiary,
            ),
          ],
        );
      },
    );
  }
}
