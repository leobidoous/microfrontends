import 'package:flutter/material.dart';

enum ButtonType { primary, secondary }

class DefaultButtonWidget extends StatelessWidget {
  final ButtonType type;
  final Function()? onPressed;
  final String text;
  final bool isEnabled;
  final bool isLoading;

  const DefaultButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
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
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            elevation: MaterialStateProperty.all(1),
          ),
          child: _buildChild(context),
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
          color: Theme.of(context).backgroundColor,
          strokeWidth: 2,
        ),
      );
    }
    late final Color color;
    switch (type) {
      case ButtonType.primary:
        color = Theme.of(context).backgroundColor;
        break;
      case ButtonType.secondary:
        color = Theme.of(context).primaryColor;
        break;
    }
    return Text(
      text,
      style: Theme.of(context).textTheme.headline6!.copyWith(color: color),
    );
  }

  Color _backgroundColor(BuildContext context) {
    switch (type) {
      case ButtonType.primary:
        return Theme.of(context).primaryColor;
      case ButtonType.secondary:
        return Theme.of(context).primaryColor;
    }
  }
}
