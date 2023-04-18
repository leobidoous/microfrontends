import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/desk/faq_entity.dart';

class FAQListItem extends StatefulWidget {
  final bool isLast;
  final FAQEntity faq;
  final bool isSelected;
  final Function(FAQEntity)? onTap;

  const FAQListItem({
    super.key,
    this.onTap,
    required this.faq,
    this.isLast = false,
    this.isSelected = false,
  });

  @override
  State<FAQListItem> createState() => _FAQListItemState();
}

class _FAQListItemState extends State<FAQListItem> {
  @override
  Widget build(BuildContext context) {
    return CustomExpansion<FAQEntity>(
      showDivider: !widget.isLast,
      value: widget.faq,
      onTap: widget.onTap,
      isSelected: widget.isSelected,
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: const Spacing(2).value),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.faq.title,
            textAlign: TextAlign.start,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: context.textTheme.fontWeightMedium,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: const Spacing(2).value),
        child: Text(
          widget.faq.content,
          style: context.textTheme.labelMedium?.copyWith(
            fontWeight: context.textTheme.fontWeightRegular,
            color: AppColorsBase.neutrla5,
          ),
        ),
      ),
    );
  }
}
