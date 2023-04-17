import 'package:core/core.dart';
import 'package:flutter/material.dart';

class GenCheckboxTile extends StatelessWidget {
  const GenCheckboxTile({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
  });

  final Widget title;
  final bool value;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      dense: true,
      title: title,
      value: value,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
      side: BorderSide(color: context.colorScheme.primary),
      checkboxShape: RoundedRectangleBorder(
        borderRadius: context.theme.borderRadiusXSM,
      ),
      checkColor: context.colorScheme.primary,
      activeColor: context.colorScheme.secondary,
      selectedTileColor: context.colorScheme.primary,
      visualDensity: VisualDensity.compact,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
