import 'package:core/core.dart';
import 'package:flutter/material.dart'
    show
        Alignment,
        BoxDecoration,
        BuildContext,
        Column,
        Container,
        CrossAxisAlignment,
        Divider,
        EdgeInsets,
        Flexible,
        Icon,
        Icons,
        InkWell,
        MainAxisSize,
        Padding,
        RichText,
        State,
        StatefulWidget,
        Text,
        TextSpan,
        Widget;

import '../../custom_dialog.dart';
import '../../custom_scroll_content.dart';

class ImageError extends StatefulWidget {
  final String error;
  const ImageError({super.key, required this.error});

  @override
  State<ImageError> createState() => _ImageErrorState();
}

class _ImageErrorState extends State<ImageError> {
  @override
  Widget build(BuildContext context) {
    final theme = context;

    return InkWell(
      onTap: () {
        CustomDialog.show(
          context,
          _buildErrorDialog(widget.error, null),
          showClose: true,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(.025),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        child: Icon(
          Icons.error_outline_rounded,
          color: theme.colorScheme.error,
        ),
      ),
    );
  }

  Widget _buildErrorDialog(Object error, StackTrace? stackTrace) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Image Error',
            style: context.textTheme.titleLarge,
          ),
          Divider(color: context.colorScheme.onBackground),
          Flexible(
            child: CustomScrollContent(
              child: RichText(
                text: TextSpan(
                  text: '$error',
                  style: context.textTheme.bodyMedium,
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
