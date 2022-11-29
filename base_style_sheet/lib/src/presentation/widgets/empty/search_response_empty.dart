import 'package:flutter/material.dart';

import '../buttons/default_button.dart';

class SearchResponseEmpty extends StatelessWidget {
  final String message;
  final String btnLabel;
  final Function()? onPressed;

  const SearchResponseEmpty({
    Key? key,
    required this.message,
    this.onPressed,
    this.btnLabel = 'Buscar novamente',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 60,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Nenhum resultado encontrado para o termo:\n',
              style: Theme.of(context).textTheme.headline6?.copyWith(),
              children: [
                TextSpan(
                  text: message,
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          if (onPressed != null) const SizedBox(height: 12),
          if (onPressed != null)
            DefaultButton(
              text: Text(
                btnLabel,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onPressed: onPressed,
            ),
        ],
      ),
    );
  }
}
