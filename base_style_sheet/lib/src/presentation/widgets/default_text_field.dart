import 'package:core/core.dart';
import 'package:flutter/material.dart'
    show
        AutovalidateMode,
        BorderRadius,
        BorderSide,
        BorderStyle,
        BoxConstraints,
        BoxDecoration,
        BuildContext,
        Container,
        EdgeInsets,
        FocusNode,
        FocusScope,
        Icon,
        IconData,
        InkWell,
        InputDecoration,
        Key,
        OutlineInputBorder,
        Radius,
        State,
        StatefulWidget,
        TextEditingController,
        TextFormField,
        TextInputAction,
        TextInputType,
        VoidCallback,
        Widget;

class DefaultTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? placeholder;
  final String? label;
  final FocusNode? focus;
  final Function(String)? onComplete;
  final bool isObscure;
  final bool readOnly;
  final IconData? prefix;
  final VoidCallback? onPrefixTap;
  final IconData? suffix;
  final VoidCallback? onSuffixTap;
  final int? maxLines;
  final int minLines;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final TextInputAction? inputAction;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final bool autofocus;
  final AutovalidateMode autovalidateMode;

  const DefaultTextField({
    Key? key,
    required this.controller,
    this.label,
    this.focus,
    this.autofocus = false,
    this.placeholder,
    this.onTap,
    this.readOnly = false,
    this.onComplete,
    this.onPrefixTap,
    this.prefix,
    this.onSuffixTap,
    this.onFieldSubmitted,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.inputAction = TextInputAction.done,
    this.suffix,
    this.maxLines = 1,
    this.validator,
    this.minLines = 1,
    this.isObscure = false,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  }) : super(key: key);

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  BoxConstraints get boxConstraints => const BoxConstraints(
        minHeight: 44,
        maxHeight: 44,
        minWidth: 48,
        maxWidth: 48,
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: context.textTheme.bodyMedium,
      onEditingComplete: () {
        widget.onComplete?.call(widget.controller.text);
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onFieldSubmitted: (input) {
        widget.onFieldSubmitted?.call(input);
      },
      autovalidateMode: widget.autovalidateMode,
      autofocus: widget.autofocus,
      focusNode: widget.focus,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      textInputAction: widget.inputAction,
      validator: widget.validator,
      obscureText: widget.isObscure,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        isDense: true,
        labelText: widget.label,
        hintText: widget.placeholder,
        labelStyle: context.textTheme.labelSmall,
        hintStyle: context.textTheme.labelSmall,
        alignLabelWithHint: true,
        contentPadding: widget.suffix != null
            ? const EdgeInsets.fromLTRB(12, 12, 0, 12)
            : const EdgeInsets.all(12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          gapPadding: 4,
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: context.colorScheme.primary,
            width: .075,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            width: .075,
            style: BorderStyle.solid,
            color: context.colorScheme.primary,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            width: .075,
            style: BorderStyle.solid,
            color: context.colorScheme.primary,
          ),
        ),
        prefixIconConstraints: boxConstraints,
        prefixIcon: widget.prefix == null
            ? null
            : InkWell(
                onTap: widget.onPrefixTap,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    color: context.colorScheme.primary,
                  ),
                  margin: const EdgeInsets.only(right: 8),
                  child: Icon(widget.prefix, size: 20),
                ),
              ),
        suffixIconConstraints: boxConstraints,
        suffixIcon: widget.suffix == null
            ? null
            : InkWell(
                onTap: widget.onSuffixTap,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    color: context.colorScheme.primary,
                  ),
                  margin: const EdgeInsets.only(left: 8),
                  child: Icon(widget.suffix, size: 20),
                ),
              ),
      ),
    );
  }
}
