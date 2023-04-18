import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../login/widgets/form_header.dart';

class RegisterCpfView extends StatefulWidget {
  const RegisterCpfView({super.key});

  @override
  State<RegisterCpfView> createState() => _RegisterCpfViewState();
}

class _RegisterCpfViewState extends State<RegisterCpfView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollContent(
      padding: EdgeInsets.all(const Spacing(3).value),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FormHeader(text: 'Agora, informe seu CPF'),
          Spacing.sm.vertical,
          Text(
            'Para confirmar sua identidade e garantir segurança nas transações.',
            textScaleFactor: 1.0,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          Spacing.sm.vertical,
          const CustomInputField(
            hintText: 'Ex: 000.000.000-00',
            keyboardType: TextInputType.name,
            labelWidget: InputLabel(label: 'Digite seu CPF'),
          ),
          Spacing.sm.vertical,
          CustomButton.text(text: 'Avançar'),
        ],
      ),
    );
  }
}
