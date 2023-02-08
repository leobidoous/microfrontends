import 'package:core/core.dart';
import 'package:flutter/material.dart'
    show
        Alignment,
        BouncingScrollPhysics,
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
        SingleChildScrollView,
        State,
        StatefulWidget,
        Text,
        TextSpan,
        Widget;

import '../../default_dialog.dart';

class PhotoError extends StatefulWidget {
  final String error;
  const PhotoError({super.key, required this.error});

  @override
  State<PhotoError> createState() => _PhotoErrorState();
}

class _PhotoErrorState extends State<PhotoError> {
  @override
  Widget build(BuildContext context) {
    final theme = context;

    return InkWell(
      onTap: () {
        DefaultDialog().show(
          context,
          _buildErrorDialog(widget.error, null),
          showClose: true,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.colorPrimaryDark.withOpacity(.025),
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
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
