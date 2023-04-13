import 'package:flutter/material.dart';

import '../../widgets/gen_app_bar.dart';

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
