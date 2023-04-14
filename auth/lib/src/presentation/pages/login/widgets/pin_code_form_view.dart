import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../domain/failures/login/login_failure.dart';
import '../../../controllers/login/login_controller.dart';
import 'form_header.dart';

class PinCodeFormView extends StatefulWidget {
  const PinCodeFormView({
    super.key,
    required this.onConfirm,
    required this.onRequestCode,
    required this.textController,
  });

  final Future Function(String phone, String code) onConfirm;
  final Function(String phone) onRequestCode;
  final TextEditingController textController;

  @override
  State<PinCodeFormView> createState() => _PinCodeFormViewState();
}

class _PinCodeFormViewState extends State<PinCodeFormView> {
  final controller = DM.i.get<LoginController>();
  final pinFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  late final String phoneNumber;

  TextStyle? get pinTextStyle => context.textTheme.bodyLarge?.copyWith(
        fontWeight: context.textTheme.fontWeightMedium,
        color: const Color(0xFF4E4B59),
      );

  PinTheme get defaultTheme => PinTheme(
        width: const Spacing(7).value,
        height: const Spacing(7).value,
        textStyle: pinTextStyle,
        decoration: BoxDecoration(
          borderRadius: context.theme.borderRadiusXSM,
          border: Border.all(color: const Color(0xFFE7E7EF)),
          color: AppColorsBase.kScaffoldBackgroundColorSecondary,
        ),
      );

  PinTheme get focusedTheme => PinTheme(
        width: const Spacing(7).value,
        height: const Spacing(7).value,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: context.colorScheme.primary),
          borderRadius: context.theme.borderRadiusXSM,
        ),
      );

  PinTheme get errorTheme => PinTheme(
        width: const Spacing(7).value,
        height: const Spacing(7).value,
        textStyle: pinTextStyle,
        decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.error),
          borderRadius: context.theme.borderRadiusXSM,
        ),
      );

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

  Future<void> _onValidateCode(String code) async {
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
    return GenScrollContent(
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
                child: Pinput(
                  length: 6,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  focusNode: pinFocus,
                  controller: widget.textController,
                  defaultPinTheme: defaultTheme,
                  focusedPinTheme: focusedTheme,
                  errorPinTheme: errorTheme,
                  pinAnimationType: PinAnimationType.fade,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onSubmitted: _onValidateCode,
                  errorText: controller.error?.message,
                  onChanged: (_) => controller.validateCode(_),
                  errorBuilder: (errorText, pin) {
                    if (controller.error is! InvalidCodeError) {
                      return const SizedBox();
                    }
                    return Padding(
                      padding: EdgeInsets.only(top: const Spacing(1).value),
                      child: Text(
                        errorText!,
                        style: pinTextStyle?.copyWith(
                          color: context.colorScheme.error,
                        ),
                      ),
                    );
                  },
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
                  onCompleted: _onValidateCode,
                  closeKeyboardWhenCompleted: true,
                  keyboardType: TextInputType.number,
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
              return GenButton.text(
                text: 'Confirmar',
                isEnabled: controller.codeIsValid,
                isLoading: controller.isLoading,
                onPressed: () => _onValidateCode(widget.textController.text),
              );
            },
          ),
        ],
      ),
    );
  }
}
