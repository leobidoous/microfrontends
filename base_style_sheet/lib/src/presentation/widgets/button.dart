import 'package:core/core.dart';
import 'package:flutter/material.dart'
    show
        AbsorbPointer,
        BorderRadius,
        BorderSide,
        BuildContext,
        ButtonStyle,
        Color,
        ColorScheme,
        Colors,
        EdgeInsets,
        ElevatedButton,
        Icon,
        IconData,
        Key,
        MainAxisAlignment,
        MainAxisSize,
        MaterialStateProperty,
        MaterialTapTargetSize,
        Opacity,
        Padding,
        RoundedRectangleBorder,
        Row,
        SafeArea,
        Size,
        SizedBox,
        State,
        StatefulWidget,
        Text,
        VisualDensity,
        Widget;

import 'loading.dart';

enum ButtonType { primary, secondary, background }

class Button extends StatefulWidget {
  final ButtonType type;
  final Function()? onPressed;
  final Widget child;
  final bool isEnabled;
  final bool isLoading;
  final bool isSafe;
  final EdgeInsets padding;

  const Button({
    Key? key,
    required this.child,
    required this.onPressed,
    this.isEnabled = true,
    this.padding = EdgeInsets.zero,
    this.isLoading = false,
    this.isSafe = false,
    this.type = ButtonType.primary,
  }) : super(key: key);

  @override
  State<Button> createState() => _ButtonState();

  static Button icon({
    required BuildContext context,
    required IconData icon,
    ButtonType type = ButtonType.primary,
    Function()? onPressed,
  }) =>
      Button(
        onPressed: onPressed,
        child: Icon(
          icon,
          size: 16,
          color: Colors.white,
        ),
      );
  static Button iconText({
    required BuildContext context,
    required String text,
    required IconData icon,
    ButtonType type = ButtonType.primary,
    Function()? onPressed,
  }) =>
      Button(
        onPressed: onPressed,
        type: type,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: type == ButtonType.secondary
                  ? context.textTheme.bodyMedium?.color
                  : Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: type == ButtonType.secondary
                  ? context.textTheme.bodyMedium
                  : context.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
            ),
          ],
        ),
      );
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.isLoading || !widget.isEnabled ? 0.5 : 1,
      child: AbsorbPointer(
        absorbing: widget.isLoading || !widget.isEnabled,
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              _backgroundColor(context.colorScheme),
            ),
            surfaceTintColor: MaterialStateProperty.all(
              _backgroundColor(context.colorScheme),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            side: MaterialStateProperty.all(
              BorderSide(
                color: _borderColor(context.colorScheme),
                width: .075,
              ),
            ),
            minimumSize: MaterialStateProperty.all(const Size(44, 44)),
            visualDensity: VisualDensity.compact,
            elevation: MaterialStateProperty.all(5),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: MaterialStateProperty.all(widget.padding),
          ),
          child: SafeArea(
            bottom: widget.isSafe,
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: widget.isLoading
                  ? const Loading(height: 16, width: 16)
                  : widget.child,
            ),
          ),
        ),
      ),
    );
  }

  Color _backgroundColor(ColorScheme colorScheme) {
    switch (widget.type) {
      case ButtonType.primary:
        return colorScheme.primary;
      case ButtonType.secondary:
        return colorScheme.secondary;
      case ButtonType.background:
        return colorScheme.surface;
    }
  }

  Color _borderColor(ColorScheme colorScheme) {
    switch (widget.type) {
      case ButtonType.primary:
        return colorScheme.onPrimary;
      case ButtonType.secondary:
        return colorScheme.onSecondary;
      case ButtonType.background:
        return colorScheme.onSecondary;
    }
  }
}
