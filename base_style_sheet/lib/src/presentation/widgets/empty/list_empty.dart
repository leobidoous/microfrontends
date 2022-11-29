import 'package:flutter/material.dart';

import '../buttons/default_button.dart';

class ListEmpty extends StatelessWidget {
  final String message;
  final String btnLabel;
  final Function()? onPressed;

  const ListEmpty({
    Key? key,
    required this.message,
    this.onPressed,
    this.btnLabel = 'Buscar novamente',
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
          Icon(
            Icons.error_outline_rounded,
            color: Theme.of(context).textTheme.bodyText1?.color,
            size: 60,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
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
