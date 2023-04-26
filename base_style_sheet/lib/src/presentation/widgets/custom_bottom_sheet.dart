import 'package:core/core.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet {
  static Future<bool?> show(
    BuildContext context,
    Widget child, {
    bool showClose = false,
    bool useSafeArea = true,
    bool isDismissible = true,
    bool isScrollControlled = true,
    Color? backgroundColor,
    EdgeInsets? padding,
  }) async {
    return await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: context.theme.borderRadiusMD.topLeft,
          topRight: context.theme.borderRadiusMD.topRight,
        ),
      ),
      backgroundColor: backgroundColor ?? context.colorScheme.background,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: _GenBottomSheet(
            useSafeArea: useSafeArea,
            showClose: showClose,
            padding: padding,
            child: child,
          ),
        );
      },
    );
  }
}

class _GenBottomSheet extends StatelessWidget {
  final Widget child;
  final bool showClose;
  final bool useSafeArea;
  final EdgeInsets? padding;

  const _GenBottomSheet({
    Key? key,
    required this.showClose,
    required this.child,
    this.padding,
    this.useSafeArea = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(
                  color: context.colorScheme.background,
                  width: 2,
                ),
                color: context.colorScheme.background,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    spreadRadius: -5,
                    color: context.colorScheme.background.withOpacity(0.5),
                  ),
                ],
              ),
              padding: padding ?? EdgeInsets.all(const Spacing(3).value),
              child: SafeArea(
                bottom: useSafeArea,
                top: useSafeArea,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showClose)
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () => Nav.to.pop(response: false),
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: const Spacing(2).value,
                            ),
                            child: GestureDetector(
                              onTap: () => Nav.to.pop(response: false),
                              child: Icon(
                                Icons.close_rounded,
                                color: context.textTheme.bodyMedium?.color,
                              ),
                            ),
                          ),
                        ),
                      ),
                    Flexible(child: child),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
