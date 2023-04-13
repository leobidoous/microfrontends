import 'package:flutter/material.dart';

class GenScrollContent extends StatelessWidget {
  const GenScrollContent({
    super.key,
    required this.child,
    this.scrollDirection = Axis.vertical,
    this.padding = EdgeInsets.zero,
    this.reverse = false,
  });

  final Widget child;
  final EdgeInsets padding;
  final Axis scrollDirection;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      reverse: reverse,
      scrollDirection: scrollDirection,
      padding: padding,
      child: child,
    );
  }
}
