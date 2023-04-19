import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../controllers/timer_controller.dart';
import '../login/widgets/form_header.dart';

class PhonePinCodeView extends StatefulWidget {
  const PhonePinCodeView({
    super.key,
    required this.onConfirm,
    required this.phoneNumber,
    required this.onRequestPhoneCode,
  });

  final Future Function(String code) onConfirm;
  final Function() onRequestPhoneCode;
  final String phoneNumber;

  @override
  State<PhonePinCodeView> createState() => _PhonePinCodeViewState();
}

class _PhonePinCodeViewState extends State<PhonePinCodeView> {
  final textController = TextEditingController();
  final timerController = TimerController();
  final formKey = GlobalKey<FormState>();
  bool pinCodeIsValid = false;
  bool isLoading = false;

  bool validatePinCode(String? input) {
    setState(() {
      pinCodeIsValid = FormValidators.emptyField(input) == null &&
          FormValidators.invalidLength(input, 6) == null;
    });
    return pinCodeIsValid;
  }

  Future<void> onConfirm() async {
    if (!(formKey.currentState?.validate() ?? true)) return;
    setState(() => isLoading = true);
    await widget.onConfirm(textController.text);
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    timerController.startTimer();
  }

  @override
  void dispose() {
    timerController.dispose();
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
          const FormHeader(
            text: 'Valide o número do seu celular',
          ),
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
              onChanged: validatePinCode,
              controller: textController,
              // onComplete: _onValidatePhoneCode,
              // errorText: controller.error?.message,
              validators: [
                FormValidators.emptyField,
                (input) => FormValidators.invalidLength(input, 6),
              ],
            ),
          ),
          Spacing.lg.vertical,
          ValueListenableBuilder(
            valueListenable: timerController,
            builder: (context, value, child) {
              return Semantics(
                button: true,
                child: InkWell(
                  onTap: !timerController.showTimer
                      ? () {
                          // controller.clearError();
                          // textController.clear();
                          // controller.onResendCode();
                        }
                      : null,
                  child: Text(
                    '''Não recebi o código ${timerController.showTimer ? '(${timerController.counter} seg)' : ''}''',
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: context.textTheme.fontWeightMedium,
                      color: !timerController.showTimer
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                ),
              );
            },
          ),
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
