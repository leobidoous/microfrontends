import 'package:core/core.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Column,
        CrossAxisAlignment,
        EdgeInsets,
        Icon,
        Icons,
        Key,
        MainAxisAlignment,
        MainAxisSize,
        Padding,
        StatelessWidget,
        Text,
        TextAlign,
        Widget;

import '../buttons/gen_button.dart';
import '../gen_scroll_content.dart';

class ListEmpty extends StatelessWidget {
  final String? asset;
  final EdgeInsets padding;
  final String message;
  final String btnLabel;
  final Function()? onPressed;

  const ListEmpty({
    Key? key,
    required this.message,
    this.onPressed,
    this.asset,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
    this.btnLabel = 'Buscar novamente',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GenScrollContent(
      expanded: false,
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (asset != null)
            SvgPicture.asset(
              asset!,
              height: const Spacing(15).value,
            ),
          if (asset == null)
            Icon(
              Icons.error_outline_rounded,
              color: context.textTheme.bodyMedium?.color,
              size: const Spacing(15).value,
            ),
          Spacing.sm.vertical,
          Text(
            message,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium,
          ),
          if (onPressed != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: GenButton.text(
                onPressed: onPressed,
                text: btnLabel,
              ),
            ),
        ],
      ),
    );
  }
}
