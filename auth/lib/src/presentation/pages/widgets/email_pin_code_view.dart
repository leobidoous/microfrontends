import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../controllers/timer_controller.dart';
import 'form_header.dart';

class EmailPinCodeView extends StatefulWidget {
  const EmailPinCodeView({
    super.key,
    required this.email,
    required this.onConfirm,
    required this.onRequestPhoneCode,
  });

  final Future<String?> Function(String code) onConfirm;
  final Function() onRequestPhoneCode;
  final String email;

  @override
  State<EmailPinCodeView> createState() => _EmailPinCodeViewState();
}

class _EmailPinCodeViewState extends State<EmailPinCodeView> {
  final textController = TextEditingController();
  final timerController = TimerController();
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
            text: 'Valide o seu e-mail',
          ),
          Spacing.sm.vertical,
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '''Insira o código de 6 dígitos que enviamos para o email ${widget.email}.''',
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
              validators: const [
                FormValidators.emptyField,
                FormValidators.invalidEmail,
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
                          timerController.startTimer();
                          widget.onRequestPhoneCode();
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
