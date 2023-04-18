import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../login/widgets/form_header.dart';

class RegisterPhoneView extends StatefulWidget {
  const RegisterPhoneView({super.key});

  @override
  State<RegisterPhoneView> createState() => _RegisterPhoneViewState();
}

class _RegisterPhoneViewState extends State<RegisterPhoneView> {
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
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          Spacing.sm.vertical,
          const CustomInputField(
            hintText: 'Ex: (00) 00000-0000',
            keyboardType: TextInputType.name,
            labelWidget: InputLabel(
              label: 'Insira o número do seu celular',
            ),
          ),
          Spacing.sm.vertical,
          CustomButton.text(text: 'Avançar'),
        ],
      ),
    );
  }
}
