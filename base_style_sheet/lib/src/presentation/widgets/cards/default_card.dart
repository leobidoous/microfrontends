import 'package:flutter/material.dart';

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
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).backgroundColor,
        borderRadius: radius ?? BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: .1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary,
            spreadRadius: -10,
            blurRadius: 15,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
