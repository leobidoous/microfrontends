import 'package:auth/src/presentation/pages/login/widgets/form_header.dart';
import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class RegisterFullNameView extends StatefulWidget {
  const RegisterFullNameView({super.key});

  @override
  State<RegisterFullNameView> createState() => _RegisterFullNameViewState();
}

class _RegisterFullNameViewState extends State<RegisterFullNameView> {
  @override
  Widget build(BuildContext context) {
    return GenScrollContent(
      padding: EdgeInsets.all(const Spacing(3).value),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FormHeader(
            text:
                'Olá, seja bem-vindo(a)! \nPara começar, digite seu nome completo:',
          ),
          Spacing.sm.vertical,
          Text(
            'Digite seu nome sem abreviações, igual ao seu documento.',
            textScaleFactor: 1.0,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          Spacing.sm.vertical,
          const GenInputField(
            hintText: 'Ex: Leonardo Dias',
            keyboardType: TextInputType.name,
            labelWidget: InputLabel(
              label: 'Digite seu nome completo',
            ),
          ),
          Spacing.sm.vertical,
          GenButton.text(text: 'Avançar'),
        ],
      ),
    );
  }
}
