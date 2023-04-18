import 'dart:io';

import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class PhotoListItem extends StatelessWidget {
  const PhotoListItem({super.key, required this.file, this.onRemove});

  final File file;
  final Function(File)? onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: context.theme.borderRadiusXSM,
        color: AppColorsBase.grey3,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: const Spacing(2).value,
        vertical: const Spacing(1).value,
      ),
      constraints: BoxConstraints(minHeight: AppThemeBase.inputHeightMD),
      child: Row(
        children: [
          CustomImage(
            file: File(file.path),
            fit: BoxFit.cover,
            radius: context.theme.borderRadiusSM,
            height: 32.responsiveHeight,
            width: 32.responsiveWidth,
          ),
          Spacing.sm.horizontal,
          Expanded(
            child: Text(
              basename(file.path),
              style: context.textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          if (onRemove != null) ...[
            Spacing.sm.horizontal,
            InkWell(
              onTap: () => onRemove?.call(file),
              child: const Icon(Icons.close_rounded),
            ),
          ],
        ],
      ),
    );
  }
}
