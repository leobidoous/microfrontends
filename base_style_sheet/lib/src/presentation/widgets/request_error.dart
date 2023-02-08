import 'package:core/core.dart';
import 'package:flutter/material.dart'
    show
        BouncingScrollPhysics,
        BuildContext,
        Colors,
        Column,
        CrossAxisAlignment,
        EdgeInsets,
        Key,
        MainAxisAlignment,
        MainAxisSize,
        Padding,
        SelectableText,
        SingleChildScrollView,
        SizedBox,
        StatelessWidget,
        Text,
        TextAlign,
        Widget;

import 'button.dart';

class RequestError extends StatelessWidget {
  final String message;
  final String btnLabel;
  final double? maxHeight;
  final EdgeInsets padding;
  final Function()? onPressed;

  const RequestError({
    Key? key,
    required this.message,
    this.onPressed,
    this.maxHeight,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
    this.btnLabel = 'Tentar novamente',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: maxHeight,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SelectableText(
                message,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium,
              ),
            ),
          ),
          if (onPressed != null)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Button(
                onPressed: onPressed,
                child: Text(
                  btnLabel,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
