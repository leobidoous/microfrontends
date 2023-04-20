import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../widgets/form_header.dart';

class RegisterFullNameView extends StatefulWidget {
  const RegisterFullNameView({super.key, required this.onConfirm});

  final Function(String) onConfirm;

  @override
  State<RegisterFullNameView> createState() => _RegisterFullNameViewState();
}

class _RegisterFullNameViewState extends State<RegisterFullNameView> {
  final textController = TextEditingController();
  bool fullNameIsValid = false;

  bool validateFullName(String? input) {
    setState(() {
      fullNameIsValid = FormValidators.invalidFullName(input) == null &&
          FormValidators.emptyField(input) == null;
    });
    return fullNameIsValid;
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
          const FormHeader(
            text:
                '''Olá, seja bem-vindo(a)! \nPara começar, digite seu nome completo:''',
          ),
          Spacing.sm.vertical,
          Text(
            'Digite seu nome sem abreviações, igual ao seu documento.',
            style: context.textTheme.bodyMedium,
          ),
          Spacing.sm.vertical,
          CustomInputField(
            hintText: 'Ex: Leonardo Dias',
            controller: textController,
            keyboardType: TextInputType.name,
            onFieldSubmitted: widget.onConfirm,
            textCapitalization: TextCapitalization.words,
            validators: const [
              FormValidators.emptyField,
              FormValidators.invalidFullName,
            ],
            onChanged: validateFullName,
            labelWidget: const InputLabel(label: 'Digite seu nome completo'),
          ),
          Spacing.sm.vertical,
          CustomButton.text(
            text: 'Avançar',
            isEnabled: fullNameIsValid,
            onPressed: () => widget.onConfirm(textController.text),
          ),
        ],
      ),
    );
  }
}
