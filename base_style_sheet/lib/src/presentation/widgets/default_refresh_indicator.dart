import 'package:core/core.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Colors,
        RefreshIndicator,
        RefreshIndicatorTriggerMode,
        StatelessWidget,
        Theme,
        Widget;

class DefaultRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const DefaultRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: context.theme.copyWith(
        shadowColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        applyElevationOverlayColor: false,
      ),
      child: RefreshIndicator(
        onRefresh: onRefresh,
        edgeOffset: 0,
        displacement: 0,
        backgroundColor: Colors.transparent,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        child: child,
      ),
    );
  }
}
