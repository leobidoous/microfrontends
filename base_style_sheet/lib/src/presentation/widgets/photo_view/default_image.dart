import 'dart:io' show File;

import 'package:core/core.dart';
import 'package:flutter/material.dart'
    show
        BorderRadius,
        BoxFit,
        BuildContext,
        Builder,
        Center,
        Icon,
        Icons,
        IgnorePointer,
        Key,
        SizedBox,
        StatelessWidget,
        Widget;

import '../default_card.dart';
import 'image_url.dart' show ImageUrl;

class DefaultImage extends StatelessWidget {
  final File? file;
  final BoxFit fit;
  final String? url;
  final double? width;
  final double? height;
  final BorderRadius radius;
  final bool enableGestures;

  const DefaultImage({
    Key? key,
    this.url,
    this.file,
    this.width,
    this.height,
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
        isSelected: true,
        child: IgnorePointer(
          ignoring: !enableGestures,
          child: Builder(
            builder: (_) {
              if (url != null) {
                return ImageUrl(
                  fit: fit,
                  url: url!,
                  width: width,
                  height: height,
                );
              }
              return Center(
                child: Icon(
                  Icons.image_not_supported_rounded,
                  size: height,
                  color: context.colorScheme.onBackground,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
