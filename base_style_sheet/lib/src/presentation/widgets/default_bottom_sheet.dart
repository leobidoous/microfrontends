import 'package:core/core.dart';
import 'package:flutter/material.dart'
    show
        BorderRadius,
        BuildContext,
        ClipRRect,
        EdgeInsets,
        Padding,
        Radius,
        RoundedRectangleBorder,
        SafeArea,
        Widget,
        WillPopScope,
        showModalBottomSheet;

class DefaultBottomSheet<T> {
  Future<T?> show(
    BuildContext context,
    Widget child, {
    isSafeArea = true,
    EdgeInsets padding = EdgeInsets.zero,
  }) async {
    return await showModalBottomSheet<T?>(
      context: context,
      useRootNavigator: false,
      isDismissible: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      backgroundColor: context.colorScheme.background,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => false,
          child: SafeArea(
            bottom: isSafeArea,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Padding(padding: padding, child: child),
            ),
          ),
        );
      },
      enableDrag: true,
    );
  }
}
