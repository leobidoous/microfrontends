import 'package:core/core.dart';
import 'package:flutter/material.dart';


class InputLabel extends StatelessWidget {
  final String label;
  final bool hasError;
  const InputLabel({
    super.key,
    required this.label,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      overflow: TextOverflow.ellipsis,
      style: context.textTheme.bodyMedium?.copyWith(
        fontWeight: context.textTheme.fontWeightLight,
        color: AppColorsBase.grey9,
      ),
    );
  }
}
