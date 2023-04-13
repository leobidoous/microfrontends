import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/themes/spacing/spacing.dart';

class FormHeader extends StatelessWidget {
  const FormHeader({super.key});

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
          'Acesse sua conta',
          style: context.textTheme.titleMedium,
        ),
      ],
    );
  }
}
