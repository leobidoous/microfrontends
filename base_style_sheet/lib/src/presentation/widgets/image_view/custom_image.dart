import 'dart:io' show File;

import 'package:core/core.dart';
import 'package:flutter/material.dart'
    show
        BorderRadius,
        BoxFit,
        BoxShadow,
        BuildContext,
        Builder,
        Center,
        Icon,
        Icons,
        IgnorePointer,
        Image,
        Key,
        SizedBox,
        StatelessWidget,
        Widget;

import '../containers/custom_card.dart';
import 'image_url.dart' show ImageUrl;

class CustomImage extends StatelessWidget {
  final File? file;
  final BoxFit fit;
  final String? url;
  final String? asset;
  final double? width;
  final double? height;
  final List<BoxShadow> shaddow;
  final BorderRadius radius;
  final bool enableGestures;

  const CustomImage({
    Key? key,
    this.url,
    this.file,
    this.width,
    this.height,
    this.asset,
    this.shaddow = const [],
    this.fit = BoxFit.contain,
    this.enableGestures = true,
    this.radius = BorderRadius.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomCard(
        radius: radius,
        shaddow: shaddow,
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
              } else if (asset != null) {
                return SvgPicture.asset(
                  asset!,
                  fit: fit,
                  width: width,
                  height: height,
                );
              } else if (file != null) {
                return Image.file(
                  file!,
                  fit: fit,
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
