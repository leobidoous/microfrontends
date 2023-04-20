import 'package:core/core.dart';
import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  const FormHeader({super.key, this.text = 'Acesse sua conta'});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: const Spacing(5).value,
            height: const Spacing(5).value,
            child: Image.asset('assets/logos/gen_symbol_light.png'),
          ),
        ),
        Spacing.md.vertical,
        Text(
          text,
          style: context.textTheme.titleMedium,
        ),
      ],
    );
  }
}
