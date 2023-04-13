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
      value: value,
      title: title,
      onChanged: onChanged,
    );
  }
}
