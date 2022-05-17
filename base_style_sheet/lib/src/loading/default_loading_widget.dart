import 'package:flutter/material.dart';

enum LoadingType { primary, linear }

class DefaultLoadingWidget extends StatelessWidget {
  const DefaultLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: 2.5,
      color: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
