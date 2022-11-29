import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:flutter/material.dart';

import '../../../../../core.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(automaticallyImplyLeading: true),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Page not found.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 16),
            DefaultButton(
              text: Text(
                'Voltar',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onPressed: Modular.to.pop,
            ),
          ],
        ),
      ),
    );
  }
}
