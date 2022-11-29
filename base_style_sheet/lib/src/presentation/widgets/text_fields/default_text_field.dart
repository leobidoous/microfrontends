import 'package:flutter/material.dart';

class DefaultTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? placeholder;
  final String? label;
  final Function(String)? onComplete;
  final bool isObscure;
  final IconData? suffix;
  final VoidCallback? onSuffixTap;
  final int? maxLines;
  final int minLines;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;

  const DefaultTextField({
    Key? key,
    required this.controller,
    this.label,
    this.placeholder,
    this.onTap,
    this.onComplete,
    this.onSuffixTap,
    this.suffix,
    this.maxLines = 1,
    this.validator,
    this.minLines = 1,
    this.isObscure = false,
  }) : super(key: key);

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: Theme.of(context).textTheme.bodyText1,
      onEditingComplete: () {
        widget.onComplete?.call(widget.controller.text);
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onTap: widget.onTap,
      validator: widget.validator,
      obscureText: widget.isObscure,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      decoration: InputDecoration(
        isDense: true,
        labelText: widget.label,
        hintText: widget.placeholder,
        labelStyle: Theme.of(context).textTheme.bodyText1,
        hintStyle: Theme.of(context).textTheme.bodyText1,
        contentPadding: const EdgeInsets.all(12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          gapPadding: 4,
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Theme.of(context).colorScheme.secondary,
            width: .25,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            width: .25,
            style: BorderStyle.solid,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            width: .25,
            style: BorderStyle.solid,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minHeight: 45,
          maxHeight: 45,
          minWidth: 50,
          maxWidth: 50,
        ),
        prefixIcon: widget.suffix == null
            ? null
            : InkWell(
                onTap: widget.onSuffixTap,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  margin: const EdgeInsets.only(right: 8),
                  child: Icon(widget.suffix, size: 20),
                ),
              ),
      ),
    );
  }
}
