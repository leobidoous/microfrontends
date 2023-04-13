import 'package:flutter/material.dart'
    show
        Border,
        BorderRadius,
        BoxDecoration,
        BoxShadow,
        BuildContext,
        Clip,
        Color,
        Container,
        EdgeInsets,
        InkWell,
        Semantics,
        StatelessWidget,
        Widget;

import '../../../../core/themes/app_colors_base.dart';
import '../../../../core/themes/app_theme_factory.dart';

class GenCard extends StatelessWidget {
  const GenCard({
    super.key,
    this.radius,
    this.border,
    this.shaddow,
    this.color,
    this.onTap,
    required this.child,
    this.isSelected = false,
    this.padding = EdgeInsets.zero,
  });

  final Function()? onTap;
  final Widget child;
  final bool isSelected;
  final EdgeInsets padding;
  final BorderRadius? radius;
  final Border? border;
  final Color? color;
  final List<BoxShadow>? shaddow;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: onTap != null,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: isSelected
                ? context.colorScheme.primary
                : color ?? context.colorScheme.background,
            borderRadius: radius ?? context.theme.borderRadiusMD,
            border: border ??
                Border.all(
                  color: AppColorsBase.neutrla1,
                  width: context.textTheme.lineHeightRegular,
                ),
            boxShadow: shaddow == null
                ? [context.theme.shadowLightmodeLevel0]
                : (shaddow?.isEmpty ?? false)
                    ? null
                    : shaddow,
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: child,
        ),
      ),
    );
  }
}
