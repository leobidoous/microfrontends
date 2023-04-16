import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class RegisterTermsView extends StatefulWidget {
  const RegisterTermsView({Key? key}) : super(key: key);

  @override
  State<RegisterTermsView> createState() => _RegisterTermsViewState();
}

class _RegisterTermsViewState extends State<RegisterTermsView> {
  final scrollController = ScrollController();
  bool showFloatingButton = true;

  @override
  void initState() {
    scrollController.addListener(() {
      final max = scrollController.position.maxScrollExtent;
      if (scrollController.offset >= max) {
        setState(() {
          showFloatingButton = false;
        });
      } else {
        setState(() {
          showFloatingButton = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const GenAppBar(title: 'Termos e Condições'),
      body: SafeArea(
        child: GenScrollContent(
          padding: EdgeInsets.all(const Spacing(3).value),
          scrollController: scrollController,
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
        ),
      ),
      floatingActionButton: showFloatingButton
          ? FloatingActionButton(
              backgroundColor: context.colorScheme.primary,
              onPressed: () {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.decelerate,
                );
              },
              child: Icon(
                Icons.arrow_downward,
                color: context.colorScheme.background,
              ),
            )
          : null,
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
          value: false,
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
