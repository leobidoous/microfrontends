import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'form_header.dart';

class EmailView extends StatefulWidget {
  const EmailView({super.key, required this.onConfirm});

  final Future Function(String) onConfirm;

  @override
  State<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  final textController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool emailIsValid = false;
  bool isLoading = false;

  bool validateEmail(String? input) {
    setState(() {
      emailIsValid = FormValidators.invalidEmail(input) == null &&
          FormValidators.emptyField(input) == null;
    });
    return emailIsValid;
  }

  Future<void> onConfirm() async {
    if (!(formKey.currentState?.validate() ?? true)) return;
    setState(() => isLoading = true);
    await widget.onConfirm(textController.text);
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
      padding: EdgeInsets.all(const Spacing(3).value),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FormHeader(text: 'Informe seu e-mail'),
          Spacing.sm.vertical,
          Text(
            '''Você irá receber um código de validação para autenticação do e-mail.''',
            style: context.textTheme.bodyMedium,
          ),
          Spacing.sm.vertical,
          CustomInputField(
            hintText: 'Ex: email@exemplo.com.br',
            controller: textController,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.emailAddress,
            validators: const [
              FormValidators.emptyField,
              FormValidators.invalidEmail,
            ],
            onChanged: validateEmail,
            onFieldSubmitted: widget.onConfirm,
            labelWidget: const InputLabel(label: 'Insira seu e-mail'),
          ),
          Spacing.sm.vertical,
          CustomButton.text(
            text: 'Avançar',
            isEnabled: emailIsValid,
            isLoading: isLoading,
            onPressed: onConfirm,
          ),
        ],
      ),
    );
  }
}
