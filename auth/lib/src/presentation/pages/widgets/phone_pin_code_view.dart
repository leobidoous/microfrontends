import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'form_header.dart';
import 'resend_code_timer.dart';

class PhonePinCodeView extends StatefulWidget {
  const PhonePinCodeView({
    super.key,
    required this.onConfirm,
    required this.phoneNumber,
    required this.onRequestPhoneCode,
  });

  final Future<String?> Function(String code) onConfirm;
  final Function() onRequestPhoneCode;
  final String phoneNumber;

  @override
  State<PhonePinCodeView> createState() => _PhonePinCodeViewState();
}

class _PhonePinCodeViewState extends State<PhonePinCodeView> {
  final textController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? errorText;
  bool pinCodeIsValid = false;
  bool isLoading = false;

  bool validatePinCode(String? input) {
    errorText = null;
    setState(() {
      pinCodeIsValid = FormValidators.emptyField(input) == null &&
          FormValidators.invalidLength(input, 6) == null;
    });
    return pinCodeIsValid;
  }

  Future<void> onConfirm() async {
    if (!(formKey.currentState?.validate() ?? true)) return;
    setState(() => isLoading = true);
    await widget.onConfirm(textController.text).then((value) {
      errorText = value;
    });
    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollContent(
      padding: EdgeInsets.all(const Spacing(2).value),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FormHeader(text: 'Valide o número do seu celular'),
          Spacing.sm.vertical,
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '''Insira o código de 6 dígitos que enviamos para o número +55 ${widget.phoneNumber}.''',
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: context.textTheme.fontWeightLight,
              ),
            ),
          ),
          Spacing.lg.vertical,
          Form(
            key: formKey,
            child: CustomPinField(
              errorText: errorText,
              onChanged: validatePinCode,
              controller: textController,
              keyboardType: TextInputType.number,
              onComplete: (_) => onConfirm(),
              validators: [
                FormValidators.emptyField,
                (input) => FormValidators.invalidLength(input, 6),
              ],
            ),
          ),
          Spacing.lg.vertical,
          ResendCodeTimer(onResendCode: widget.onRequestPhoneCode),
          Spacing.md.vertical,
          CustomButton.text(
            text: 'Confirmar',
            isEnabled: pinCodeIsValid,
            isLoading: isLoading,
            onPressed: onConfirm,
          ),
        ],
      ),
    );
  }
}
