import 'package:flutter/material.dart';

import '../../dialogs/default_dialog.dart';

class PhotoError extends StatelessWidget {
  final String error;
  const PhotoError({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        DefaultDialog().show(
          context,
          _buildErrorDialog(context, error, null),
          showClose: true,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withOpacity(.025),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        child: Icon(
          Icons.error_outline_rounded,
          color: Theme.of(context).errorColor,
        ),
      ),
    );
  }

  Widget _buildErrorDialog(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Image Error',
            style: Theme.of(context).textTheme.headline3,
          ),
          Divider(
            color: Theme.of(context).colorScheme.onBackground,
          ),
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: RichText(
                text: TextSpan(
                  text: '$error',
                  style: Theme.of(context).textTheme.bodyText1,
                  children: [
                    if (stackTrace != null)
                      TextSpan(
                        text: '\n\n$stackTrace',
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
