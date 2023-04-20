import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'input_label.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    Key? key,
    this.textCapitalization = TextCapitalization.sentences,
    this.inputFormatters = const [],
    this.initialValue,
    this.labelText = '',
    this.errorText = '',
    this.hintText,
    this.prefix,
    this.keyboardType,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.validators,
    this.validator,
    this.onChanged,
    this.focusNode,
    this.maxLength,
    this.maxLines = 1,
    this.autofocus = true,
    this.textInputAction,
    this.enabled = true,
    this.labelWidget,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.padding = EdgeInsets.zero,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.readOnly = false,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
  }) : super(key: key);

  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final List<String? Function(String?)>? validators;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function(String?)? onChanged;
  final String? initialValue;
  final String? labelText;
  final String? errorText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final String? prefix;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final int? maxLength;
  final int maxLines;
  final bool autofocus;
  final bool enabled;
  final bool obscureText;
  final EdgeInsets padding;
  final AutovalidateMode? autovalidateMode;
  final Function(String)? onFieldSubmitted;
  final bool readOnly;
  final Function()? onEditingComplete;
  final InputLabel? labelWidget;
  final FloatingLabelBehavior floatingLabelBehavior;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  BoxConstraints get boxConstraints => BoxConstraints(
        minHeight: AppThemeBase.inputHeightMD,
        minWidth: AppThemeBase.inputHeightMD,
      );

  String? _validator(String? input) {
    String? error;
    widget.validators?.forEach((val) {
      if (error == null) {
        error = val(input);
        return;
      }
    });
    return error;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.labelWidget != null) ...[
            widget.labelWidget!,
            Spacing.xxs.vertical,
          ],
          TextFormField(
            key: widget.key,
            readOnly: widget.readOnly,
            enabled: widget.enabled,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            focusNode: widget.focusNode,
            controller: widget.controller,
            onEditingComplete: widget.onEditingComplete,
            initialValue: widget.initialValue,
            inputFormatters: widget.inputFormatters,
            textCapitalization: widget.textCapitalization,
            keyboardType: widget.keyboardType,
            onFieldSubmitted: widget.onFieldSubmitted,
            autovalidateMode: widget.autovalidateMode,
            textInputAction: widget.textInputAction ?? TextInputAction.done,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: context.textTheme.fontWeightRegular,
              color: AppColorsBase.grey10,
            ),
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              isDense: false,
              hintStyle: context.textTheme.labelLarge?.copyWith(
                fontWeight: context.textTheme.fontWeightRegular,
                color: AppColorsBase.grey19,
              ),
              labelStyle: context.textTheme.titleMedium?.copyWith(
                fontWeight: context.textTheme.fontWeightMedium,
                color: AppColorsBase.grey8,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: const Spacing(2).value,
                vertical: const Spacing(1).value,
              ),
              helperStyle: context.textTheme.labelSmall,
              prefix: Text(widget.prefix ?? ''),
              suffixIconConstraints: boxConstraints,
              prefixIconConstraints: boxConstraints,
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              hintText: widget.hintText,
              labelText: widget.labelText,
              errorText: widget.errorText == '' ? null : widget.errorText,
              errorStyle: context.textTheme.labelSmall?.copyWith(
                color: AppColorsBase.error0,
              ),
              constraints: boxConstraints,
              errorMaxLines: 2,
              counterText: '',
              floatingLabelBehavior: widget.floatingLabelBehavior,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColorsBase.grey7),
                borderRadius: context.theme.borderRadiusSM,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: context.theme.borderRadiusSM,
                borderSide: BorderSide(color: AppColorsBase.grey7),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: context.theme.borderRadiusSM,
                borderSide: BorderSide(color: AppColorsBase.grey7),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: context.theme.borderRadiusSM,
                borderSide: BorderSide(color: AppColorsBase.error0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: context.theme.borderRadiusSM,
                borderSide: BorderSide(color: AppColorsBase.error0),
              ),
              alignLabelWithHint: true,
            ),
            onChanged: widget.onChanged,
            autofocus: widget.autofocus,
            validator: widget.validator ?? _validator,
          ),
        ],
      ),
    );
  }
}
