import 'package:core/core.dart';
import 'package:flutter/material.dart'
    show
        StatelessWidget,
        Widget,
        BuildContext,
        Chip,
        Text,
        RoundedRectangleBorder,
        EdgeInsets,
        MaterialTapTargetSize;

class DefaultChip extends StatelessWidget {
  final String name;
  final bool isSelected;
  final Function()? onTap;

  const DefaultChip({
    super.key,
    required this.name,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(name, style: context.textTheme.bodyMedium),
      shape: RoundedRectangleBorder(borderRadius: AppThemeBase.borderRadiusSM),
      onDeleted: onTap,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: isSelected
          ? context.colorScheme.secondary
          : context.colorScheme.onPrimary,
    );
  }
}
