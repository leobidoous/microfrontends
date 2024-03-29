import 'package:core/core.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Widget,
        showGeneralDialog,
        Colors,
        MaterialLocalizations,
        WillPopScope,
        StatelessWidget,
        Key,
        Icons,
        SafeArea,
        Padding,
        EdgeInsets,
        Column,
        MainAxisAlignment,
        MainAxisSize,
        Align,
        Alignment,
        GestureDetector,
        Container,
        BoxDecoration,
        BorderRadius,
        Flexible,
        Border,
        BoxShadow,
        ClipRRect,
        Material;

import 'button.dart';
import 'request_error.dart';

class DefaultDialog {
  Future<bool?> show(
    BuildContext context,
    Widget child, {
    bool showClose = false,
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
          child: _DefaultDialogWidget(showClose: showClose, child: child),
        );
      },
    );
  }

  Future<bool?> error(
    BuildContext context, {
    required String message,
  }) async {
    return await show(
      context,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: RequestError(message: message),
      ),
      showClose: true,
    );
  }
}

class _DefaultDialogWidget extends StatelessWidget {
  final bool showClose;
  final Widget child;

  const _DefaultDialogWidget({
    Key? key,
    required this.showClose,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
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
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Button.icon(
                      context: context,
                      icon: Icons.close_rounded,
                    ),
                  ),
                ),
              ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: context.colorScheme.background,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: -5,
                      color: context.colorScheme.background.withOpacity(0.5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Material(
                    color: context.colorScheme.background,
                    child: child,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
