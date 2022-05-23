import 'package:flutter/material.dart';

class DefaultTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String? placeholder;
  final String? label;
  final Function(String)? onComplete;

  const DefaultTextFieldWidget({
    Key? key,
    required this.controller,
    this.label,
    this.placeholder,
    this.onComplete,
  }) : super(key: key);

  @override
  State<DefaultTextFieldWidget> createState() => _DefaultTextFieldWidgetState();
}

class _DefaultTextFieldWidgetState extends State<DefaultTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: Theme.of(context).textTheme.headline6,
      onEditingComplete: () {
        widget.onComplete?.call(widget.controller.text);
        FocusScope.of(context).requestFocus(FocusNode());
      },
      decoration: InputDecoration(
        isDense: true,
        labelText: widget.label,
        hintText: widget.placeholder,
        labelStyle: Theme.of(context).textTheme.headline6,
        hintStyle: Theme.of(context).textTheme.headline6,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          gapPadding: 4,
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Theme.of(context).primaryColor,
            width: 0.75,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
