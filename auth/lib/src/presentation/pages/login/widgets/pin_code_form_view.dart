import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../controllers/login/login_controller.dart';
import 'form_header.dart';

class PinCodeFormView extends StatefulWidget {
  const PinCodeFormView({
    super.key,
    required this.onConfirm,
    required this.onRequestPhoneCode,
    required this.textController,
  });

  final Future Function(String phone, String code) onConfirm;
  final Function(String phone) onRequestPhoneCode;
  final TextEditingController textController;

  @override
  State<PinCodeFormView> createState() => _PinCodeFormViewState();
}

class _PinCodeFormViewState extends State<PinCodeFormView> {
  final controller = DM.i.get<LoginController>();
  final formKey = GlobalKey<FormState>();
  late final String phoneNumber;
  final pinFocus = FocusNode();

  @override
  void initState() {
    widget.textController.clear();
    pinFocus.requestFocus();
    phoneNumber = controller.phoneNumber;
    super.initState();
  }

  @override
  void dispose() {
    pinFocus.dispose();
    super.dispose();
  }

  Future<void> _onValidatePhoneCode(String code) async {
    controller.clearError();
    formKey.currentState?.validate();
    await widget.onConfirm(phoneNumber, code).then((value) {
      if (controller.hasError) {
        formKey.currentState?.validate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollContent(
      padding: EdgeInsets.all(const Spacing(2).value),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FormHeader(),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '''Insira o código de 6 dígitos que enviamos para o número +55 $phoneNumber.''',
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: context.textTheme.fontWeightLight,
              ),
            ),
          ),
          Spacing.lg.vertical,
          ValueListenableBuilder(
            valueListenable: controller.timerController,
            builder: (context, value, child) {
              return Form(
                key: formKey,
                child: CustomPinField(
                  focusNode: pinFocus,
                  onChanged: (input) => controller.validateCode(input ?? ''),
                  controller: widget.textController,
                  onComplete: _onValidatePhoneCode,
                  errorText: controller.error?.message,
                  validator: (input) {
                    String? error;
                    for (var val in [FormValidators.emptyField]) {
                      if (error == null) {
                        error = val(input);
                        continue;
                      }
                    }
                    return error ?? controller.error?.message;
                  },
                ),
              );
            },
          ),
          Spacing.lg.vertical,
          ValueListenableBuilder(
            valueListenable: controller.timerController,
            builder: (context, value, child) {
              return Semantics(
                button: true,
                child: InkWell(
                  onTap: !controller.timerController.showTimer
                      ? () {
                          controller.clearError();
                          widget.textController.clear();
                          controller.onResendCode();
                        }
                      : null,
                  child: Text(
                    '''Não recebi o código ${controller.timerController.showTimer ? '(${controller.timerController.counter} seg)' : ''}''',
                    textScaleFactor: 1.0,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: context.textTheme.fontWeightMedium,
                      color: !controller.timerController.showTimer
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                ),
              );
            },
          ),
          Spacing.md.vertical,
          ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, value, child) {
              return CustomButton.text(
                text: 'Confirmar',
                isEnabled: controller.codeIsValid,
                isLoading: controller.isLoading,
                onPressed: () =>
                    _onValidatePhoneCode(widget.textController.text),
              );
            },
          ),
        ],
      ),
    );
  }
}
