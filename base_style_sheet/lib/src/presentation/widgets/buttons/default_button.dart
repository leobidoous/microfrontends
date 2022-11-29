import 'package:flutter/material.dart';

enum ButtonType { primary, secondary, background }

class DefaultButton extends StatelessWidget {
  final ButtonType type;
  final Function()? onPressed;
  final Widget text;
  final bool isEnabled;
  final bool isLoading;
  final bool isSafe;
  final EdgeInsets padding;

  const DefaultButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
    this.padding = EdgeInsets.zero,
    this.isLoading = false,
    this.isSafe = false,
    this.type = ButtonType.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isLoading || !isEnabled ? 0.5 : 1,
      child: AbsorbPointer(
        absorbing: isLoading || !isEnabled,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              _backgroundColor(context),
            ),
            surfaceTintColor: MaterialStateProperty.all(
              _backgroundColor(context),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            side: MaterialStateProperty.all(
              BorderSide(
                color: _borderColor(context),
                width: 2,
              ),
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            elevation: MaterialStateProperty.all(5),
            padding: MaterialStateProperty.all(padding),
          ),
          child: SafeArea(
            bottom: isSafe,
            top: false,
            child: _buildChild(context),
          ),
        ),
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: 10,
        width: 10,
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.secondary,
          strokeWidth: 2,
        ),
      );
    }
    return text;
  }

  Color _backgroundColor(BuildContext context) {
    switch (type) {
      case ButtonType.primary:
        return Theme.of(context).colorScheme.primary;
      case ButtonType.secondary:
        return Theme.of(context).colorScheme.secondary;
      case ButtonType.background:
        return Theme.of(context).colorScheme.surface;
    }
  }

  Color _borderColor(BuildContext context) {
    switch (type) {
      case ButtonType.primary:
        return Theme.of(context).colorScheme.primary;
      case ButtonType.secondary:
        return Theme.of(context).colorScheme.secondary;
      case ButtonType.background:
        return Theme.of(context).colorScheme.secondary;
    }
  }
}
