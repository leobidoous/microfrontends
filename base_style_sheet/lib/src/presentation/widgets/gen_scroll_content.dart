import 'package:flutter/material.dart';

import '../../../base_style_sheet.dart';

class GenScrollContent extends StatelessWidget {
  const GenScrollContent({
    super.key,
    required this.child,
    this.scrollDirection = Axis.vertical,
    this.padding = EdgeInsets.zero,
    this.reverse = false,
    this.expanded = true,
    this.scrollController,
    this.onRefresh,
  });

  final Widget child;
  final ScrollController? scrollController;
  final EdgeInsets padding;
  final Axis scrollDirection;
  final bool reverse;
  final bool expanded;
  final Future Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    final scroll = SingleChildScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      controller: scrollController,
      reverse: reverse,
      scrollDirection: scrollDirection,
      padding: padding,
      child: child,
    );
    if (expanded) {
      switch (scrollDirection) {
        case Axis.vertical:
          if (onRefresh != null) {
            return GenRefreshIndicator(
              onRefresh: onRefresh!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [Expanded(child: scroll)],
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [Expanded(child: scroll)],
          );
        default:
          return scroll;
      }
    } else if (onRefresh != null) {
      return GenRefreshIndicator(child: scroll, onRefresh: onRefresh!);
    }
    return scroll;
  }
}
