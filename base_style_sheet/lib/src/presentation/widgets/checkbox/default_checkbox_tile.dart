import 'package:flutter/material.dart';

class DefaultCheckboxTile extends StatelessWidget {
  final String name;
  final bool isChecked;
  final Function()? onTap;

  const DefaultCheckboxTile({
    super.key,
    this.onTap,
    required this.name,
    required this.isChecked,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: isChecked,
            fillColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.secondary,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            onChanged: (value) => onTap?.call(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
          Flexible(
            child: Tooltip(
              message: name,
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          )
        ],
      ),
    );
  }
}
