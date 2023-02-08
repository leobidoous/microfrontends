import 'package:core/core.dart';
import 'package:flutter/material.dart'
    show
        StatelessWidget,
        Widget,
        EdgeInsets,
        BorderRadius,
        BuildContext,
        Container,
        BoxDecoration,
        Border,
        BoxShadow,
        Clip;

class DefaultCard extends StatelessWidget {
  final Widget child;
  final bool isSelected;
  final EdgeInsets padding;
  final BorderRadius? radius;

  const DefaultCard({
    super.key,
    this.radius,
    required this.child,
    this.isSelected = false,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: isSelected
            ? context.colorScheme.primary
            : context.colorScheme.background,
        borderRadius: radius ?? BorderRadius.circular(8),
        border: Border.all(
          color: context.colorScheme.primary,
          width: .075,
        ),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.onPrimary,
            spreadRadius: -15,
            blurRadius: 15,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
