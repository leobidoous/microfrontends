import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class FeatCommingSoonPage extends StatelessWidget {
  const FeatCommingSoonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Em breve',
        leadingIcon: Icon(Icons.close_rounded),
      ),
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
