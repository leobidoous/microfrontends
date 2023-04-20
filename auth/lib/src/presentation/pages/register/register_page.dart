import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../auth.dart';
import '../../../domain/failures/register_failure.dart';
import '../../controllers/register/register_controller.dart';
import '../widgets/phone_pin_code_view.dart';
import 'widgets/register_address_view.dart.dart';
import 'widgets/register_cpf_view.dart.dart';
import 'widgets/register_email_view.dart';
import 'widgets/register_full_name_view.dart.dart';
import 'widgets/register_phone_view.dart';
import 'widgets/register_terms_view.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    Key? key,
    required this.redirectTo,
    required this.onLoginCallback,
  }) : super(key: key);

  final BasePath redirectTo;
  final Future Function(SessionEntity) onLoginCallback;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controller = DM.i.get<RegisterController>();
  final scrollController = ScrollController();
  final pageController = PageController();
  bool showFloatingButton = true;
  int pageIndex = 0;

  bool get isLastStep => pageIndex == 6;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      final max = scrollController.position.maxScrollExtent;
      if (scrollController.offset >= max) {
        if (showFloatingButton) setState(() => showFloatingButton = false);
      } else {
        if (!showFloatingButton) setState(() => showFloatingButton = true);
      }
    });
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

  Future<void> onRefuseTerms() async {
    await CustomDialog.show(
      context,
      CustomAlert(
        asset: 'assets/images/server/warning.svg',
        title: '''Você tem certeza que deseja recusar os termos?''',
        btnConfirmLabel: 'Recusar',
        content:
            '''Você será redirecionado para tela de login e poderá se cadastrar quando quiser.''',
        onConfirm: () {
          Nav.to.popUntil(
            ModalRoute.withName(AuthRoutes.root.completePath),
          );
        },
        btnCancelLabel: 'Cancelar',
        onCancel: Nav.to.pop,
      ),
      showClose: true,
    );
  }

  Future<void> onValidateCpfAlreadyExists(String cpf) async {
    FocusScope.of(context).requestFocus(FocusNode());
    await controller.onValidateCpfAlreadyExists(cpf: cpf).then((value) async {
      if (controller.hasError) {
        await showDialogError(controller.error);
        return;
      }

      controller.onUpdateForm(cpf: cpf);
      onNextPage();
    });
  }

  Future<void> onStartRegister(String phone, {bool isResend = false}) async {
    FocusScope.of(context).requestFocus(FocusNode());
    await controller.onStartRegister(phone: phone).then((value) async {
      if (controller.hasError) {
        await showDialogError(controller.error);
        return;
      }
      if (isResend) return;
      controller.onUpdateForm(phone: phone);
      onNextPage();
    });
  }

  Future<String?> onValidatePhoneCode(String code) async {
    FocusScope.of(context).requestFocus(FocusNode());
    return await controller.onValidatePhoneCode(code: code).then((value) async {
      if (controller.hasError) {
        await showDialogError(controller.error);
        return controller.error?.message;
      }
      onNextPage();
      return null;
    });
  }

  Future<void> onFinishRegister() async {
    controller.onUpdateForm(
      termAcceptedAt: DateFormat.toDateTime(
        DateTime.now(),
        pattern: 'yyyy-MM-dd HH:mm:ss',
      ),
    );
    await controller.onFinishRegister(controller.customer).then((value) async {
      if (controller.hasError) {
        await showDialogError(controller.error);
        return;
      }
      await CustomDialog.show(
        context,
        CustomAlert(
          asset: 'assets/images/parking/ticket_paid_success.svg',
          title: 'Conta criada com sucesso',
          content:
              'Realize seu login para aproveitar nossas funcionalidades 😄',
          btnConfirmLabel: 'Ir para o login',
          onConfirm: () => Nav.to.pushReplacementNamed(
            AuthRoutes.login,
            arguments: {
              'onLoginCallback': widget.onLoginCallback,
              'redirectTo': widget.redirectTo,
            },
          ),
        ),
      );
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: CustomAppBar(
          title: isLastStep ? 'Termos e Condições' : 'Cadastro',
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
                if (isLastStep) {
                  showFloatingButton = true;
                }
                pageIndex = index;
              });
            },
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              RegisterFullNameView(
                onConfirm: (fullName) {
                  controller.onUpdateForm(name: fullName);
                  onNextPage();
                },
              ),
              RegisterCpfView(onConfirm: onValidateCpfAlreadyExists),
              RegisterPhoneView(onConfirm: onStartRegister),
              PhonePinCodeView(
                onConfirm: onValidatePhoneCode,
                phoneNumber: controller.phoneNumber,
                onRequestPhoneCode: () => onStartRegister(
                  controller.phoneNumber,
                  isResend: true,
                ),
              ),
              RegisterEmailView(
                onConfirm: (email) {
                  controller.onUpdateForm(email: email);
                  onNextPage();
                },
              ),
              RegisterAddressView(
                onConfirm: (address) {
                  controller.onUpdateForm(address: address);
                  onNextPage();
                },
              ),
              RegisterTermsView(
                scrollController: scrollController,
                onConfirm: onFinishRegister,
                onCancel: onRefuseTerms,
              ),
            ],
          ),
        ),
        floatingActionButton: showFloatingButton && isLastStep
            ? FloatingActionButton(
                mini: true,
                backgroundColor: context.colorScheme.primary,
                onPressed: () {
                  scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.decelerate,
                  );
                },
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: context.colorScheme.background,
                ),
              )
            : null,
      ),
    );
  }
}
