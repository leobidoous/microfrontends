import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart'
    show BoxFit, BuildContext, Image, StatelessWidget, Widget;

import '../loading.dart';

class ImageUrl extends StatelessWidget {
  final BoxFit fit;
  final String url;
  final double? width;
  final double? height;

  const ImageUrl({
    super.key,
    required this.fit,
    required this.url,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => const Loading(),
      imageBuilder: (context, image) {
        return Image(
          image: image,
          fit: fit,
        );
      },
    );
  }
}
