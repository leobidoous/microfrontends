import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../auth.dart';
import '../../../domain/failures/login_failure.dart';
import '../../controllers/login_controller.dart';
import 'widgets/phone_form_view.dart';
import 'widgets/pin_code_form_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
    required this.redirectTo,
    required this.onLoginCallback,
  }) : super(key: key);

  final BasePath redirectTo;
  final Future Function(SessionEntity) onLoginCallback;

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

  Future<void> onRequestPhoneCode(String phone) async {
    FocusScope.of(context).requestFocus(FocusNode());
    controller.phoneNumber = phone;
    await controller.onRequestPhoneCode(phone: phone).then((value) async {
      if (controller.hasError) {
        await _showDialogError(controller.error);
        return;
      }
      pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.decelerate,
      );
    });
  }

  Future<void> onValidatePhoneCode(String phone, String code) async {
    FocusScope.of(context).requestFocus(FocusNode());
    await controller
        .onValidatePhoneCode(phone: phone, code: code)
        .then((value) async {
      if (controller.hasError) {
        await _showDialogError(controller.error);
        return;
      }
      Nav.to.navigate(widget.redirectTo);
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
          onConfirm: Nav.to.pop,
        ),
        showClose: true,
      ).then((value) {
        Nav.to.pushReplacementNamed(
          AuthRoutes.register.prevPath(),
          arguments: {
            'onLoginCallback': widget.onLoginCallback,
            'redirectTo': widget.redirectTo,
          },
        );
      });
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
            PhoneFormView(
              textController: phoneController,
              onConfirm: onRequestPhoneCode,
            ),
            PinCodeFormView(
              textController: codeController,
              onRequestPhoneCode: onRequestPhoneCode,
              onConfirm: onValidatePhoneCode,
            ),
          ],
        ),
      ),
    );
  }
}
