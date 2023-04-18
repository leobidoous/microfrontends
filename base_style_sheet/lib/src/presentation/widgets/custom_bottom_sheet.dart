import 'package:core/core.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet {

  static Future<bool?> show(
    BuildContext context,
    Widget child, {
    bool showClose = false,
    EdgeInsets? padding,
  }) async {
    return await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,

      barrierColor: Colors.black.withOpacity(0.8),
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: _GenBottomSheet(
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
  final EdgeInsets? padding;

  const _GenBottomSheet({
    Key? key,
    required this.showClose,
    required this.child,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                margin: EdgeInsets.all(const Spacing(3).value),
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
                            padding: const EdgeInsets.only(bottom: 16),
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
                    Flexible(
                      child: Material(
                        color: context.colorScheme.background,
                        child: child,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
  }
}