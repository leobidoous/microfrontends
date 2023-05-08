import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../open_banking_routes.dart';

class OpenBankingPage extends StatefulWidget {
  const OpenBankingPage({super.key});

  @override
  State<OpenBankingPage> createState() => _OpenBankingPageState();
}

class _OpenBankingPageState extends State<OpenBankingPage> {

  @override
  void initState() {
    super.initState();

    Nav.to.pushNamed(OpenBankingRoutes.onBoarding.relativePath);

  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomLoading(),
    );
  }
}
