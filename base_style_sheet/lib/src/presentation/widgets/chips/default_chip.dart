import 'package:flutter/material.dart';

class DefaultChip extends StatelessWidget {
  final String name;
  final Function()? onTap;

  const DefaultChip({
    super.key,
    required this.name,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        name,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onDeleted: onTap,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: Theme.of(context).colorScheme.secondary,
    );
  }
}
