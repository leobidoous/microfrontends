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
        CustomCard(
          onTap: onTap,
          child: SizedBox(
            width: 64.responsiveHeight,
            height: 64.responsiveHeight,
            child: Icon(icon, color: context.colorScheme.primary),
          ),
        ),
        Spacing.xs.vertical,
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColorsBase.neutrla5,
          ),
        ),
      ],
    );
  }
}
