import 'package:flutter/material.dart';

import '../buttons/default_button.dart';

class RequestError extends StatelessWidget {
  final String message;
  final String btnLabel;
  final double? maxHeight;
  final Function()? onPressed;

  const RequestError({
    Key? key,
    required this.message,
    this.onPressed,
    this.maxHeight,
    this.btnLabel = 'Tentar novamente',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: maxHeight,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
          if (onPressed != null) const SizedBox(height: 12),
          if (onPressed != null)
            DefaultButton(
              text: Text(
                btnLabel,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              onPressed: onPressed,
            ),
        ],
      ),
    );
  }
}
