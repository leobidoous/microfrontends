import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../custom_loading.dart';

enum ButtonType {
  primary,
  secondary,
  tertiary,
  background,
}

class CustomButton extends StatefulWidget {
  final ButtonType type;
  final Function()? onPressed;
  final Widget child;
  final bool isEnabled;
  final bool isLoading;
  final bool isSafe;
  final EdgeInsets padding;

  const CustomButton({
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
  State<CustomButton> createState() => _CustomButtonState();

  static Widget iconValue(
    IconData iconData, {
    ButtonType type = ButtonType.primary,
  }) {
    return Builder(
      builder: (context) {
        late final Color color;
        switch (type) {
          case ButtonType.primary:
            color = context.colorScheme.background;
            break;
          default:
            color = context.colorScheme.primary;
            break;
        }
        return Icon(
          iconData,
          size: AppFontSize.iconButton.value,
          color: color,
        );
      },
    );
  }

  static Widget textValue(
    String text, {
    ButtonType type = ButtonType.primary,
  }) {
    return Builder(
      builder: (context) {
        late final Color color;
        switch (type) {
          case ButtonType.background:
            color = context.colorScheme.primary;
            break;
          default:
            color = context.isDarkMode
                ? context.colorScheme.onBackground
                : context.colorScheme.background;
            break;
        }
        return Text(
          text,
          style: context.textTheme.titleMedium?.copyWith(
            color: color,
          ),
        );
      },
    );
  }

  factory CustomButton.text({
    ButtonType type = ButtonType.primary,
    Function()? onPressed,
    required String text,
    bool isEnabled = true,
    bool isLoading = false,
    bool isSafe = false,
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    return CustomButton(
      onPressed: onPressed,
      type: type,
      isEnabled: isEnabled,
      isLoading: isLoading,
      padding: padding,
      child: textValue(text, type: type),
    );
  }
  factory CustomButton.icon({
    ButtonType type = ButtonType.primary,
    Function()? onPressed,
    required IconData icon,
    bool isEnabled = true,
    bool isLoading = false,
    bool isSafe = false,
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    return CustomButton(
      onPressed: onPressed,
      type: type,
      isEnabled: isEnabled,
      isLoading: isLoading,
      padding: padding,
      child: iconValue(icon, type: type),
    );
  }
  factory CustomButton.iconText({
    ButtonType type = ButtonType.primary,
    Function()? onPressed,
    required IconData icon,
    required String text,
    bool isEnabled = true,
    bool isLoading = false,
    bool isSafe = false,
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    return CustomButton(
      onPressed: onPressed,
      type: type,
      isEnabled: isEnabled,
      isLoading: isLoading,
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          iconValue(icon, type: type),
          const SizedBox(width: 8),
          textValue(text, type: type),
        ],
      ),
    );
  }
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: !widget.isEnabled ? 0.5 : 1,
      child: AbsorbPointer(
        absorbing: widget.isLoading || !widget.isEnabled,
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(_backgroundColor),
            surfaceTintColor: MaterialStateProperty.all(_surfaceTintColor),
            overlayColor: MaterialStateProperty.all(_overlayColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: context.theme.borderRadiusSM,
              ),
            ),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            side: MaterialStateProperty.all(
              BorderSide(
                color: _borderColor,
                width: context.theme.borderWidthXS,
              ),
            ),
            minimumSize: MaterialStateProperty.all(
              Size(AppThemeBase.buttonHeightMD, AppThemeBase.buttonHeightMD),
            ),
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
                  ? const CustomLoading(height: 16, width: 16)
                  : widget.child,
            ),
          ),
        ),
      ),
    );
  }

  Color get _backgroundColor {
    switch (widget.type) {
      case ButtonType.primary:
        return context.colorScheme.primary;
      case ButtonType.secondary:
        return context.colorScheme.secondary;
      case ButtonType.background:
        return Colors.transparent;
      case ButtonType.tertiary:
        return AppColorsBase.success2;
    }
  }

  Color get _surfaceTintColor {
    switch (widget.type) {
      case ButtonType.primary:
        return context.colorScheme.primary;
      case ButtonType.secondary:
        return context.colorScheme.secondary;
      case ButtonType.background:
        return context.colorScheme.background;
      case ButtonType.tertiary:
        return AppColorsBase.success2;
    }
  }

  Color get _overlayColor {
    switch (widget.type) {
      case ButtonType.primary:
        return context.colorScheme.onPrimary.withOpacity(.1);
      case ButtonType.secondary:
        return context.colorScheme.onSecondary.withOpacity(.1);
      case ButtonType.background:
        return context.colorScheme.onBackground.withOpacity(.1);
      case ButtonType.tertiary:
        return AppColorsBase.success1;
    }
  }

  Color get _borderColor {
    switch (widget.type) {
      case ButtonType.primary:
        return context.colorScheme.primary;
      case ButtonType.secondary:
        return context.colorScheme.secondary;
      case ButtonType.background:
        return context.colorScheme.primary;
      case ButtonType.tertiary:
        return AppColorsBase.success2;
    }
  }
}
