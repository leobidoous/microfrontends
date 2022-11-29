import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/dropdown_entity.dart';

class DefaultDropdown extends StatelessWidget {
  final IconData dropItem;
  final DropdownEntity value;
  final List<DropdownEntity> items;
  final Function(DropdownEntity?)? onChanged;

  const DefaultDropdown({
    Key? key,
    required this.value,
    required this.items,
    this.dropItem = CoreIcons.sortDescending,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<DropdownEntity>(
      borderRadius: BorderRadius.circular(12),
      decoration: const InputDecoration(
        isDense: true,
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        fillColor: Colors.transparent,
      ),
      focusColor: Colors.transparent,
      alignment: Alignment.centerRight,
      icon: Icon(
        dropItem,
        size: 16,
        color: Theme.of(context).textTheme.bodyText1?.color,
      ),
      autofocus: false,
      isDense: true,
      value: value,
      isExpanded: true,
      onChanged: onChanged,
      dropdownColor: Theme.of(context).backgroundColor,
      selectedItemBuilder: (_) {
        return items.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Text(
                item.getName.toString(),
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          );
        }).toList();
      },
      items: items.map((item) {
        return DropdownMenuItem(
          child: Text(
            item.getName.toString(),
            style: Theme.of(context).textTheme.bodyText1,
          ),
          value: item,
        );
      }).toList(),
    );
  }
}
