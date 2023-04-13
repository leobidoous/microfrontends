import 'package:flutter/material.dart';

import '../../../../core/themes/spacing/spacing.dart';
import '../../widgets/gen_app_bar.dart';

class FeatCommingSoonPage extends StatelessWidget {
  const FeatCommingSoonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenAppBar(title: 'Em breve'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Em breve disponível para você!',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          Spacing.lg.vertical,
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: const Spacing(6).value,
            ),
            child: Image.asset(
              'assets/images/undraw_happy_news_re_tsbd 2.png',
            ),
          ),
        ],
      ),
    );
  }
}
