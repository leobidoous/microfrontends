import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../login/widgets/form_header.dart';

class RegisterEmailView extends StatefulWidget {
  const RegisterEmailView({super.key});

  @override
  State<RegisterEmailView> createState() => _RegisterEmailViewState();
}

class _RegisterEmailViewState extends State<RegisterEmailView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollContent(
      padding: EdgeInsets.all(const Spacing(3).value),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FormHeader(text: 'Agora, informe seu e-mail'),
          Spacing.sm.vertical,
          Text(
            'Você irá receber um código de validação para autenticação do e-mail.',
            textScaleFactor: 1.0,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          Spacing.sm.vertical,
          const CustomInputField(
            hintText: 'Ex: email@exemplo.com.br',
            keyboardType: TextInputType.name,
            labelWidget: InputLabel(label: 'Insira seu e-mail'),
          ),
          Spacing.sm.vertical,
          CustomButton.text(text: 'Avançar'),
        ],
      ),
    );
  }
}
