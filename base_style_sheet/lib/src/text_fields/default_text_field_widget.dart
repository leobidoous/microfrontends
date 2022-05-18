import 'package:flutter/material.dart';

class DefaultTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String? placeholder;
  final String label;

  const DefaultTextFieldWidget({
    Key? key,
    required this.controller,
    required this.label,
    this.placeholder,
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
      decoration: InputDecoration(
        isDense: true,
        labelText: widget.label,
        hintText: widget.placeholder,
        labelStyle: Theme.of(context).textTheme.headline6,
        hintStyle: Theme.of(context).textTheme.headline6,
        contentPadding: const EdgeInsets.all(12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          gapPadding: 4,
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Theme.of(context).primaryColor,
            width: 0.75,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
