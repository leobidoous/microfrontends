import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:flutter/material.dart';

import '../../../../../core.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page not found')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("'${Modular.to.path}' not found"),
            const SizedBox(height: 12),
            DefaultButtonWidget(text: 'Voltar', onPressed: Modular.to.pop),
          ],
        ),
      ),
    );
  }
}
