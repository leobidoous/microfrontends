import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:flutter/material.dart';

class OpenBankingPage extends StatefulWidget {
  const OpenBankingPage({super.key});

  @override
  State<OpenBankingPage> createState() => _OpenBankingPageState();
}

class _OpenBankingPageState extends State<OpenBankingPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: GenAppBar(title: 'Open Banking'),
    );
  }
}
