import 'package:flutter/material.dart';

import '../../base_style_sheet.dart';

class RequestErrorWidget extends StatelessWidget {
  final String message;
  final String btnLabel;
  final Function()? onPressed;

  const RequestErrorWidget({
    Key? key,
    required this.message,
    this.onPressed,
    this.btnLabel = 'Tentar novamente',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
          if (onPressed != null) const SizedBox(height: 12),
          if (onPressed != null)
            DefaultButtonWidget(text: btnLabel, onPressed: onPressed),
        ],
      ),
    );
  }
}
