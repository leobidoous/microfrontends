import 'package:core/core.dart';
import 'package:flutter/material.dart';

class MallLocation extends StatelessWidget {
  const MallLocation({
    super.key,
    required this.shopping,
    this.padding = EdgeInsets.zero,
  });

  final ShoppingEntity shopping;
  final EdgeInsets padding;

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
        padding: padding,
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
                    shopping.address,
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
