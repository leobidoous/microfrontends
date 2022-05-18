import 'package:flutter/material.dart';

import '../../../../../core.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page not found')),
      body: Center(
        child: Text("'${Modular.to.path}' not found"),
      ),
    );
  }
}
