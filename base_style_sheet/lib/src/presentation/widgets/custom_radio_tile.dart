import 'package:core/core.dart';
import 'package:flutter/material.dart';

class CustomRadioTile<T> extends StatelessWidget {
  const CustomRadioTile({
    super.key,
    required this.value,
    required this.title,
    this.isSelected = false,
    this.onChanged,
  });
  final Widget title;
  final T value;
  final bool isSelected;
  final Function(T?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: InkWell(
        onTap: () => onChanged?.call(value),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: isSelected ? 5 : 1,
                  color: isSelected
                      ? context.colorScheme.primary
                      : AppColorsBase.neutrla4,
                ),
              ),
              height: const Spacing(2.75).value,
              width: const Spacing(2.75).value,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colorScheme.background,
                ),
              ),
            ),
            Spacing.xs.horizontal,
            Flexible(child: title),
          ],
        ),
      ),
    );
  }
}
