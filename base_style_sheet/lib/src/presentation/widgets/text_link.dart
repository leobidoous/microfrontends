import 'package:core/core.dart';
import 'package:flutter/material.dart';


class TextLink extends StatelessWidget {
  const TextLink({
    super.key,
    required this.text,
    this.underline = false,
    this.isEnabled = true,
    this.onTap,
  });

  final Function()? onTap;
  final String text;
  final bool underline;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnabled ? 1 : .5,
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        child: Text(
          text,
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colorScheme.primary,
            fontWeight: context.textTheme.fontWeightMedium,
            decoration: underline ? TextDecoration.underline : null,
          ),
        ),
      ),
    );
  }
}
