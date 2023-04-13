import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart' hide ServerError, UnknowError;
import 'package:flutter/material.dart';

import '../../../domain/failures/login/login_failure.dart';
import '../../controllers/login/login_controller.dart';
import 'widgets/phone_form_view.dart';
import 'widgets/pin_code_form_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
    required this.redirectTo,
    required this.onLoginCallback,
  }) : super(key: key);

  final BasePath redirectTo;
  final Future Function() onLoginCallback;
  
  @override
  State<LoginPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<LoginPage> {
  final controller = DM.i.get<LoginController>();
  final pageController = PageController();
  final phoneController = TextEditingController();
  final codeController = TextEditingController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<void> onRequestCode(String phone) async {
    FocusScope.of(context).requestFocus(FocusNode());
    controller.phoneNumber = phone;
    await controller.onRequestCode(phone: phone).then((value) async {
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

  Future<void> onValidateCode(String phone, String code) async {
    FocusScope.of(context).requestFocus(FocusNode());
    await controller
        .onValidateCode(phone: phone, code: code)
        .then((value) async {
      if (controller.hasError) {
        await _showDialogError(controller.error);
        return;
      }
      Nav.to.pushNamedAndRemoveUntil(
        SharedRoutes.splash,
        ModalRoute.withName(SharedRoutes.splash.completePath),
      );
    });
  }

  Future<void> _showDialogError(ILoginFailure? error) async {
    if (controller.error is ServerError) {
      await GenDialog.show(
        context,
        GenAlert.serverError(context),
        showClose: true,
      );
    } else if (controller.error is UnknowError) {
      await GenDialog.show(
        context,
        GenAlert.paymentError(context),
        showClose: true,
      );
    } else if (controller.error is AccountNotExist) {
      await GenDialog.show(
        context,
        GenAlert(
          asset: 'assets/images/server/warning.svg',
          title: 'Você não tem um cadastro ativo conosco.',
          content: controller.error?.message ?? '',
          btnConfirmLabel: 'Ir para o cadastro',
          onConfirm: Nav.to.pop,
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
        appBar: GenAppBar(
          title: 'Login',
          showDivider: false,
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
              onConfirm: onRequestCode,
            ),
            PinCodeFormView(
              textController: codeController,
              onRequestCode: onRequestCode,
              onConfirm: onValidateCode,
            ),
          ],
        ),
      ),
    );
  }
}
