import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart' hide UnknowError, ServerError;
import 'package:flutter/material.dart';

import '../../../../../l10n/translations.dart';
import '../../../../domain/entities/dashboard/ticket_entity.dart';
import '../../../../domain/entities/ticket/ticket_payment_request_entity.dart';
import '../../../../domain/failures/dashboard/dashboard_failure.dart';
import '../../../controllers/ticket/ticket_payment_controller.dart';
import '../../../controllers/ticket/ticket_payment_method_controller.dart';
import '../../../controllers/ticket/ticket_submit_controller.dart';
import '../../../routes/parking_routes.dart';
import '../../../routes/ticket_routes.dart';
import '../widgets/ticket_card_details.dart';
import '../widgets/ticket_header.dart';
import 'widgets/ticket_payment_method.dart';

class TicketSubmitPageArgs {
  final String ticketOrPlate;
  final VoidCallback? onPop;

  TicketSubmitPageArgs({required this.ticketOrPlate, this.onPop});
}

class TicketSubmitPage extends StatefulWidget {
  const TicketSubmitPage({super.key, required this.args});
  final TicketSubmitPageArgs args;

  @override
  State<TicketSubmitPage> createState() => _TicketSubmitPageState();
}

class _TicketSubmitPageState extends State<TicketSubmitPage> {
  final paymentMethodController = DM.i.get<TicketPaymentMethodController>();
  final paymentController = DM.i.get<TicketPaymentController>();
  final session = DM.i.get<SessionEntity>();
  final controller = DM.i.get<TicketSubmitController>();
  final shopping = DM.i.get<ShoppingEntity>();

  @override
  void initState() {
    super.initState();
    _onFetchTicketDetails();
  }

  @override
  void dispose() {
    controller.dispose();
    paymentController.dispose();
    paymentMethodController.dispose();
    super.dispose();
  }

  void _onFetchTicketDetails() {
    controller
        .fetchTicketDetails(
      code: widget.args.ticketOrPlate,
      idShopping: shopping.id.toString(),
    )
        .then((value) async {
      if (controller.hasError) {
        await CustomDialog.show(
          context,
          CustomAlert.ticketNotFoundError(context),
          showClose: true,
        ).then((value) => Nav.to.pop());
        return;
      }
    });

    if (controller.state.discount.percentOfDiscount != 1) {
      paymentMethodController.fetchFavoriteCreditCard();
    }
  }

  Future<void> _onValidateOrPayTicket() async {
    if (!session.customer.emailVerifiedAt.isNotEmpty) {
      await CustomDialog.show(
        context,
        CustomAlert.emailVerified(context),
        showClose: true,
      );
      return;
    }

    await paymentController
        .onPaymentTicket(
      paymentRequest: TicketPaymentRequestEntity(
        idMall: shopping.id.toString(),
        customer: session.customer.id,
        sessionId: DateTime.now().toString(),
        transaction: controller.state.transacao,
        last4: controller.state.plate == null
            ? paymentMethodController.state.last4
            : null,
      ),
    )
        .then((value) async {
      if (paymentController.hasError) {
        if (paymentController.error is ServerError) {
          await CustomDialog.show(
            context,
            CustomAlert.serverError(context),
            showClose: true,
          );
        } else if (paymentController.error is UnknowError) {
          await CustomDialog.show(
            context,
            CustomAlert.paymentError(context),
            showClose: true,
          );
        }
      } else {
        if (controller.state.discount.percentOfDiscount == 1) {
          await CustomDialog.show(
            context,
            CustomAlert.freeTicketSuccess(context),
            showClose: true,
          ).then((value) {
            Nav.to.popUntil(
              ModalRoute.withName(ParkingRoutes.root.completePath),
            );
          });
          return;
        }
        await CustomDialog.show(
          context,
          CustomAlert.ticketPaidSuccess(
            context,
            double.tryParse(paymentController.state.valorPago) ?? 0,
            controller.state.validadeDatahora,
            isPlate: (controller.state.plate != null),
          ),
          showClose: true,
        ).then((value) async {
          controller.state.plate != null
              ? () {}
              : await Nav.to.pushNamed(
                  TicketRoutes.ticketVoucherDetails.prevPath(),
                  arguments: [
                    paymentController.state,
                    paymentMethodController.state,
                  ],
                ).then((value) {
                  Nav.to.popUntil(
                    ModalRoute.withName(TicketRoutes.root.completePath),
                  );
                  Nav.to.pushNamed(TicketRoutes.ticketTracking.prevPath(2));
                });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          backgroundColor: context.colorScheme.background,
          title: Tr.of(context).ticketTitle,
          leadingIcon: const Icon(Icons.close),
          onBackTap: widget.args.onPop,
          actions: [
            AppBarButton(
              child: Icon(
                CoreIcons.contactUs,
                color: context.colorScheme.onBackground,
              ),
              onTap: () => DM.i.get<ZendeskController>().openChat(),
            ),
          ],
        ),
        backgroundColor: context.colorScheme.background,
        body: SafeArea(
          child: ValueListenableBuilder<TicketEntity>(
            valueListenable: controller,
            builder: (context, ticket, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: _ticketDetails),
                  Padding(
                    padding: EdgeInsets.all(const Spacing(2).value),
                    child: _paymentButton,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget get _ticketDetails {
    final ticket = controller.state;
    return CustomRefreshIndicator(
      onRefresh: () async {
        _onFetchTicketDetails();
      },
      child: Column(
        children: [
          Expanded(
            child: CustomScrollContent(
              padding: EdgeInsets.all(const Spacing(2).value),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TicketHeader(controller: controller, shopping: shopping),
                  Spacing.sm.vertical,
                  TicketCardDetails(
                    ticket: ticket,
                    isLoading: controller.isLoading,
                    hasError: controller.hasError,
                  ),
                  if (ticket.discount.percentOfDiscount != 1) ...[
                    Spacing.sm.vertical,
                    TicketPaymentMethod(
                      paymentMethodController: paymentMethodController,
                      ticketSubmitController: controller,
                      emailVerified:
                          session.customer.emailVerifiedAt.isNotEmpty,
                    ),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _paymentButton {
    return ValueListenableBuilder(
      valueListenable: paymentMethodController,
      builder: (context, value, child) {
        return ValueListenableBuilder(
          valueListenable: paymentController,
          builder: (context, value, child) {
            if (controller.isLoading) {
              return CustomShimmer(height: AppThemeBase.buttonHeightMD);
            }
            return CustomButton.text(
              text: (controller.state.discount.percentOfDiscount != 1)
                  ? Tr.of(context).payTextButton
                  : Tr.of(context).validateParking,
              type: ButtonType.tertiary,
              isEnabled: !controller.hasError &&
                  (paymentMethodController.state.id.isNotEmpty ||
                      controller.state.discount.id == 3),
              isLoading: paymentController.isLoading,
              onPressed: _onValidateOrPayTicket,
            );
          },
        );
      },
    );
  }
}
