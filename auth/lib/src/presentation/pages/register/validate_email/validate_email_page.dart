import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../domain/failures/register_failure.dart';
import '../../../controllers/validate_email_controller.dart';
import '../../widgets/email_pin_code_view.dart';
import '../../widgets/email_view.dart';

class ValidateEmailPage extends StatefulWidget {
  const ValidateEmailPage({super.key, required this.onValidateCallback});

  final Future Function(CustomerEntity) onValidateCallback;

  @override
  State<ValidateEmailPage> createState() => _ValidateEmailPageState();
}

class _ValidateEmailPageState extends State<ValidateEmailPage> {
  final customer = DM.i.get<SessionEntity>().customer;
  final controller = DM.i.get<ValidateEmailController>();
  final scrollController = ScrollController();
  final pageController = PageController();
  bool showFloatingButton = true;
  int pageIndex = 0;

  bool get isLastStep => pageIndex == 6;

  Future<void> updateUser(String email) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final customer = CustomerModel.fromEntity(this.customer).copyWith(
      email: email,
    );
    await controller
        .updateUser(customer, widget.onValidateCallback)
        .then((value) async {
      if (controller.hasError) {
        await showDialogError(controller.error);
        return;
      }
      controller.email = email;
      await onRequestEmailCode(email);
    });
  }

  Future<void> onRequestEmailCode(String email, {bool isResend = false}) async {
    FocusScope.of(context).requestFocus(FocusNode());
    await controller.onRequestEmailCode().then((value) async {
      if (controller.hasError) {
        await showDialogError(controller.error);
        return;
      }
      if (isResend) return;
      onNextPage();
    });
  }

  Future<String?> onValidateEmailCode(String token) async {
    FocusScope.of(context).requestFocus(FocusNode());
    return await controller.onValidateEmailCode(token).then((value) async {
      if (controller.hasError) {
        await showDialogError(controller.error);
        return controller.error?.message;
      }
      await CustomDialog.show(
        context,
        CustomAlert(
          asset: 'assets/images/parking/ticket_paid_success.svg',
          title: 'E-mail validado com sucesso',
          content:
              'Agora você pode aproveitar todas as nossas funcionalidades 🥳',
          btnConfirmLabel: 'Fechar',
          onConfirm: Nav.to.pop,
        ),
      );
      Nav.to.pop();
      return null;
    });
  }

  Future<void> showDialogError(IRegisterFailure? error) async {
    final isServerError = controller.error.runtimeType == ServerError ||
        controller.error.runtimeType == UnknowError;
    await CustomDialog.show(
      context,
      CustomAlert(
        asset: isServerError
            ? 'assets/images/server/server_error.svg'
            : 'assets/images/server/warning.svg',
        title: controller.error!.message.toString(),
        btnConfirmLabel: 'Fechar',
        content: controller.error!.detailError.toString(),
        onConfirm: Nav.to.pop,
      ),
      showClose: true,
    );
    return;
  }

  void onNextPage() {
    pageController.animateToPage(
      pageIndex + 1,
      curve: Curves.decelerate,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Validação do e-mail',
          progress: (pageIndex + 1) / 2,
          onBackTap: () {
            if (pageIndex > 0) {
              pageController.animateToPage(
                pageIndex - 1,
                curve: Curves.decelerate,
                duration: const Duration(milliseconds: 250),
              );
            } else {
              Nav.to.pop();
            }
          },
        ),
        body: SafeArea(
          child: PageView(
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              EmailView(onConfirm: updateUser),
              EmailPinCodeView(
                email: controller.email,
                onRequestEmailCode: () async {
                  await onRequestEmailCode(controller.email, isResend: true);
                },
                onConfirm: onValidateEmailCode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
