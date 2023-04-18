import 'package:core/core.dart';
import 'package:flutter/material.dart'
    show
        Align,
        Alignment,
        Border,
        BorderRadius,
        BoxDecoration,
        BoxShadow,
        BuildContext,
        Colors,
        Column,
        Container,
        EdgeInsets,
        Flexible,
        GestureDetector,
        Icon,
        Icons,
        Key,
        MainAxisAlignment,
        MainAxisSize,
        Material,
        MaterialLocalizations,
        Padding,
        SafeArea,
        StatelessWidget,
        Widget,
        WillPopScope,
        showGeneralDialog;

import 'request_error.dart';

class CustomDialog {
  static Future<bool?> show(
    BuildContext context,
    Widget child, {
    bool showClose = false,
    EdgeInsets? padding,
  }) async {
    return await showGeneralDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.8),
      transitionDuration: const Duration(milliseconds: 250),
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      pageBuilder: (_, animation, secondaryAnimation) {
        return WillPopScope(
          onWillPop: () async => false,
          child: _CustomDialog(
            showClose: showClose,
            padding: padding,
            child: child,
          ),
        );
      },
    );
  }

  Future<bool?> error(
    BuildContext context, {
    required String message,
    EdgeInsets? padding,
  }) async {
    return await show(
      context,
      Padding(
        padding: padding ?? EdgeInsets.all(const Spacing(3).value),
        child: RequestError(message: message, padding: EdgeInsets.zero),
      ),
      showClose: true,
    );
  }
}

class _CustomDialog extends StatelessWidget {
  final bool showClose;
  final Widget child;
  final EdgeInsets? padding;

  const _CustomDialog({
    Key? key,
    required this.showClose,
    required this.child,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
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
                    Flexible(child: child),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
