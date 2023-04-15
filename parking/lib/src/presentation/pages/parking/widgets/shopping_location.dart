import 'package:core/core.dart';
import 'package:flutter/material.dart';

class MallLocation extends StatelessWidget {
  final ShoppingModel shopping;
  const MallLocation({super.key, required this.shopping});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColorsBase.grey2),
          top: BorderSide(color: AppColorsBase.grey2),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: const Spacing(2).value,
          vertical: const Spacing(1).value,
        ),
        child: Row(
          children: [
            Icon(GenIcons.locationPinAlt, color: AppColorsBase.grey6),
            Spacing.sm.horizontal,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(shopping.name),
                  Spacing.xxs.vertical,
                  Text(
                    shopping.address ?? '-',
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
