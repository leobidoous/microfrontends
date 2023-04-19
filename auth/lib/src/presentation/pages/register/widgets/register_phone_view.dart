import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../login/widgets/form_header.dart';

class RegisterPhoneView extends StatefulWidget {
  const RegisterPhoneView({super.key, required this.onConfirm});

  final Function(String) onConfirm;

  @override
  State<RegisterPhoneView> createState() => _RegisterPhoneViewState();
}

class _RegisterPhoneViewState extends State<RegisterPhoneView> {
  final phoneField = const ValueKey('phone_field');
  final textController = TextEditingController();
  bool phoneIsValid = false;

  bool validatePhone(String? input) {
    setState(() {
      phoneIsValid = FormValidators.invalidPhone(input) == null &&
          FormValidators.emptyField(input) == null;
    });
    return phoneIsValid;
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
          const FormHeader(text: 'Digite o número do seu celular'),
          Spacing.sm.vertical,
          Text(
            'Você irá receber um código por SMS, para autenticação automática.',
            textScaleFactor: 1.0,
            style: context.textTheme.bodyMedium,
          ),
          Spacing.sm.vertical,
          CustomInputField(
            key: phoneField,
            hintText: 'Ex: (00) 00000-0000',
            controller: textController,
            keyboardType: TextInputType.number,
            validators: const [
              FormValidators.emptyField,
              FormValidators.invalidPhone,
            ],
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              FormMasks.phone(),
            ],
            onChanged: validatePhone,
            labelWidget: const InputLabel(
              label: 'Insira o número do seu celular',
            ),
          ),
          Spacing.sm.vertical,
          CustomButton.text(
            text: 'Avançar',
            isEnabled: phoneIsValid,
            onPressed: () => widget.onConfirm(textController.text),
          ),
        ],
      ),
    );
  }
}
