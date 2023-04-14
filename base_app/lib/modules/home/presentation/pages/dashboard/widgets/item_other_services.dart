import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ItemOtherServices extends StatelessWidget {
  const ItemOtherServices({
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
    return InkWell(
      onTap: onTap,
      child: GenCard(
        radius: BorderRadius.circular(const Spacing(1).value),
        child: SizedBox(
          width: 96,
          height: 96,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: AppColorsBase.neutrla7,
                size: 20,
              ),
              Spacing.sm.vertical,
              Text(
                title,
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall!.copyWith(
                  fontSize: 10,
                  fontWeight: AppFontWeight.regular.value,
                  color: AppColorsBase.neutrla5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
