import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../base_style_sheet.dart';
import 'widgets/photo_error.dart';

class ImageFile extends StatelessWidget {
  final BoxFit fit;
  final File file;
  final double? width;
  final double? height;

  const ImageFile({
    super.key,
    required this.fit,
    required this.file,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => PhotoView(image: FileImage(file)).show(context),
      child: Image.file(
        file,
        fit: fit,
        errorBuilder: (context, error, __) {
          return PhotoError(error: '$error\n$__');
        },
      ),
    );
  }
}
