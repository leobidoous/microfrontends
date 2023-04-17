import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class RegisterTermsView extends StatefulWidget {
  const RegisterTermsView({Key? key, required this.scrollController}) : super(key: key);

  final ScrollController scrollController;

  @override
  State<RegisterTermsView> createState() => _RegisterTermsViewState();
}

class _RegisterTermsViewState extends State<RegisterTermsView> {
  @override
  Widget build(BuildContext context) {
    return GenScrollContent(
      padding: EdgeInsets.all(const Spacing(3).value),
      scrollController: widget.scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RichText(
            text: TextSpan(
              text: 'Por fim, veja abaixo e ',
              children: <TextSpan>[
                TextSpan(
                  text: 'aceite ',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const TextSpan(
                  text:
                      'nosso Termos e Condições de uso e Termo de confidencialidade',
                ),
              ],
              style: GoogleFonts.inter(
                fontSize: 27.0,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          ),
          Spacing.sm.vertical,
          const GenTerms(),
          Spacing.sm.vertical,
          _checkboxesTerms,
          Spacing.sm.vertical,
          GenButton.text(
            text: 'ACEITAR',
          ),
          Spacing.sm.vertical,
          GenButton.text(
            text: 'RECUSAR',
            type: ButtonType.background,
          ),
        ],
      ),
    );
  }

  Widget get _checkboxesTerms {
    return Column(
      children: [
        GenCheckboxTile(
          title: Text(
            'Termos e Condições',
            style: context.textTheme.bodyMedium,
          ),
          value: false,
        ),
        GenCheckboxTile(
          title: Text(
            'Política de Dados e Privacidade',
            style: context.textTheme.bodyMedium,
          ),
          value: true,
        ),
        GenCheckboxTile(
          title: Text(
            'Política de Segurança',
            style: context.textTheme.bodyMedium,
          ),
          value: false,
        ),
      ],
    );
  }
}
