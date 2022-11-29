import 'package:flutter/material.dart';

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
    return RefreshIndicator(
      onRefresh: onRefresh,
      edgeOffset: 0,
      displacement: 0,
      backgroundColor: Colors.transparent,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      child: child,
    );
  }
}
