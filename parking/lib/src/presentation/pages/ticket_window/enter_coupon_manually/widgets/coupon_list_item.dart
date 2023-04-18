import 'dart:io';

import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/entities/ticket_window/unique_coupon_entity.dart';

class CouponListItem extends StatefulWidget {
  const CouponListItem({
    super.key,
    required this.coupon,
    required this.onUpdateValue,
  });

  final UniqueCouponEntity coupon;
  final Function(double?) onUpdateValue;

  @override
  State<CouponListItem> createState() => _CouponListItemState();
}

class _CouponListItemState extends State<CouponListItem> {
  final duration = const Duration(milliseconds: 250);
  late final TextEditingController textController;
  final formKey = GlobalKey<FormState>();
  late bool isEditing;

  @override
  void initState() {
    super.initState();
    isEditing = widget.coupon.value == null;
    textController = TextEditingController(
      text: widget.coupon.value?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isEditing = !isEditing;
        });
      },
      child: AnimatedSwitcher(
        duration: duration,
        transitionBuilder: (child, animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: Builder(
          key: ValueKey(isEditing),
          builder: (context) {
            if (!isEditing) return _input;
            return _fileItem;
          },
        ),
      ),
    );
  }

  Widget get _input {
    return Container(
      color: context.colorScheme.background,
      child: Form(
        key: formKey,
        child: CustomInputField(
          hintText: 'Ex.: 150,00',
          keyboardType: TextInputType.number,
          validators: [
            FormValidators.emptyField,
            FormValidators.invalidDouble,
            (input) {
              if (input == null || input.isEmpty) return null;
              return FormValidators.invalidGreaterThan(input, 0.01);
            }
          ],
          controller: textController,
          padding: EdgeInsets.zero,
          suffixIcon: InkWell(
            onTap: () {
              if (!(formKey.currentState?.validate() ?? false)) {
                return;
              }
              setState(() {
                widget.onUpdateValue(
                  textController.text.tryParseToDouble,
                );
                isEditing = !isEditing;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: context.theme.borderRadiusXSM.topRight,
                  bottomRight: context.theme.borderRadiusXSM.bottomRight,
                ),
                color: context.colorScheme.primary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: const Spacing(2).value,
                    ),
                    child: Text(
                      'Salvar',
                      style: context.textTheme.labelLarge?.copyWith(
                        color: context.colorScheme.background,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _fileItem {
    return Container(
      decoration: BoxDecoration(
        borderRadius: context.theme.borderRadiusXSM,
        color: AppColorsBase.grey3,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: const Spacing(2).value,
        vertical: const Spacing(1).value,
      ),
      constraints: BoxConstraints(
        minHeight: AppThemeBase.inputHeightMD,
      ),
      child: Row(
        children: [
          CustomImage(
            file: File(widget.coupon.file.path),
            fit: BoxFit.cover,
            radius: context.theme.borderRadiusSM,
            height: 32.responsiveHeight,
            width: 32.responsiveWidth,
          ),
          Spacing.sm.horizontal,
          Expanded(
            child: Text(NumberFormat.toCurrency(widget.coupon.value)),
          ),
          Spacing.sm.horizontal,
          InkWell(
            onTap: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
            child: const Icon(Icons.edit_note_rounded),
          ),
        ],
      ),
    );
  }
}
