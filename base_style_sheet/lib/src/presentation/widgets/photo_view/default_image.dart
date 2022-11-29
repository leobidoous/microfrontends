import 'dart:io';

import 'package:core/core.dart' show TokenEntity;
import 'package:flutter/material.dart';

import '../../../../base_style_sheet.dart';
import 'image_file.dart';
import 'image_url.dart';

class DefaultImage extends StatelessWidget {
  final File? file;
  final BoxFit fit;
  final String? url;
  final double? width;
  final double? height;
  final TokenEntity? token;
  final BorderRadius radius;
  final bool enableGestures;

  const DefaultImage({
    Key? key,
    this.url,
    this.file,
    this.width,
    this.height,
    this.token,
    this.fit = BoxFit.contain,
    this.enableGestures = true,
    this.radius = BorderRadius.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DefaultCard(
        radius: radius,
        child: IgnorePointer(
          ignoring: !enableGestures,
          child: Builder(
            builder: (_) {
              if (file != null) {
                return ImageFile(
                  fit: fit,
                  file: file!,
                  width: width,
                  height: height,
                );
              }
              if (url != null) {
                return ImageUrl(
                  fit: fit,
                  url: url!,
                  token: token,
                  width: width,
                  height: height,
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
