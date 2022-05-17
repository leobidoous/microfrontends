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
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.placeholder,
      )
    );
  }
}
