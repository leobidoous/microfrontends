import 'package:core/core.dart';
import 'package:flutter/material.dart';

typedef VoidFunction = void Function(String);

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String? hintText;
  final String? initialValue;
  final VoidFunction callBack;
  final GlobalKey<FormFieldState>? formKey;

  const CustomDropdown({
    Key? key,
    required this.items,
    this.hintText,
    this.initialValue,
    required this.callBack,
    this.formKey,
  }) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String? selectedValue = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButtonFormField<String>(
        key: widget.formKey,
        isExpanded: true,
        hint: Text(widget.hintText ?? ''),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: const Spacing(2).value,
            right: const Spacing(2).value,
            bottom: const Spacing(2).value,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColorsBase.neutrla3),
            borderRadius: context.theme.borderRadiusSM,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColorsBase.neutrla3),
            borderRadius: context.theme.borderRadiusSM,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColorsBase.neutrla3),
            borderRadius: context.theme.borderRadiusSM,
          ),
        ),
        icon: Icon(
          CoreIcons.downOutline,
          color: AppColorsBase.neutrla5,
        ),
        iconSize: 16,
        value: selectedValue,
        items: widget.items
            .map<DropdownMenuItem<String>>(
              (String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColorsBase.neutrla5),
                ),
              ),
            )
            .toList(),
        style: context.textTheme.bodyMedium!.copyWith(
          fontFamily: 'Poppins',
          fontWeight: AppFontWeight.light.value,
          color: AppColorsBase.neutrla5,
        ),
        onChanged: (String? newValue) {
          selectedValue = newValue;
          widget.callBack(newValue ?? '');
        },
      ),
    );
  }
}
