import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../auth.dart';
import '../../../domain/failures/login_failure.dart';
import '../../controllers/login_controller.dart';
import '../widgets/phone_pin_code_view.dart';
import 'widgets/phone_form_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.redirectTo}) : super(key: key);

  final BasePath redirectTo;

  @override
  State<LoginPage> createState() => _LoginPagePageState();
}

class _LoginPagePageState extends State<LoginPage> {
  final controller = DM.i.get<LoginController>();
  final pageController = PageController();
  final phoneController = TextEditingController();
  final codeController = TextEditingController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<void> onRequestPhoneCode(String phone, {bool isResend = false}) async {
    FocusScope.of(context).requestFocus(FocusNode());
    controller.phoneNumber = phone;
    await controller.onRequestPhoneCode(phone: phone).then((value) async {
      if (controller.hasError) {
        await _showDialogError(controller.error);
        return;
      }

      if (isResend) return;
      pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.decelerate,
      );
    });
  }

  Future<String?> onValidatePhoneCode(String code) async {
    FocusScope.of(context).requestFocus(FocusNode());
    return await controller
        .onValidatePhoneCode(code: code, phone: controller.phoneNumber)
        .then((value) async {
      if (controller.hasError) {
        await _showDialogError(controller.error);
        return controller.error?.message;
      }
      Nav.to.navigate(widget.redirectTo);
      return null;
    });
  }

  Future<void> _showDialogError(ILoginFailure? error) async {
    if (controller.error is ServerError) {
      await CustomDialog.show(
        context,
        CustomAlert.serverError(context),
        showClose: true,
      );
    } else if (controller.error is UnknowError) {
      await CustomDialog.show(
        context,
        CustomAlert.serverError(context),
        showClose: true,
      );
    } else if (controller.error is AccountNotExist) {
      await CustomDialog.show(
        context,
        CustomAlert(
          asset: 'assets/images/server/warning.svg',
          title: 'Você não tem um cadastro ativo conosco.',
          content: controller.error?.message ?? '',
          btnConfirmLabel: 'Ir para o cadastro',
          onConfirm: () {
            Nav.to.pushReplacementNamed(
              RegisterRoutes.root,
              arguments: {'redirectTo': widget.redirectTo},
            );
          },
        ),
        showClose: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Login',
          onBackTap: () {
            if (pageController.page?.round() == 0) {
              Nav.to.pop();
            } else {
              pageController.animateToPage(
                0,
                duration: const Duration(milliseconds: 250),
                curve: Curves.decelerate,
              );
            }
          },
        ),
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            PhoneFormView(onConfirm: onRequestPhoneCode),
            PhonePinCodeView(
              onConfirm: onValidatePhoneCode,
              phoneNumber: controller.phoneNumber,
              onRequestPhoneCode: () => onRequestPhoneCode(
                controller.phoneNumber,
                isResend: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
