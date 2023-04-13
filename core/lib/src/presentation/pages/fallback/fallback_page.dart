import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:flutter/material.dart';


class FallbackPage extends StatelessWidget {
  const FallbackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: GenAppBar(title: 'Ops :/'),
      body: Center(child: Text('Page not found. ⚠️')),
    );
  }
}
