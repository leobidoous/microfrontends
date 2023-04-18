import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ItemMainServices extends StatelessWidget {
  const ItemMainServices({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: GenCard(
            radius: BorderRadius.circular(const Spacing(1).value),
            child: SizedBox(
              width: 56,
              height: 56,
              child: Center(
                child: Icon(
                  icon,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        Spacing.xs.vertical,
        Text(
          title,
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColorsBase.neutrla5,
          ),
        ),
      ],
    );
  }
}
