import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../alerts/gen_alert.dart';
import '../gen_dialog.dart';
import '../gen_loading.dart';

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
    if (url.isEmpty) {
      return SvgPicture.asset(
        'assets/images/server/server_error.svg',
        fit: fit,
      );
    }
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => const GenLoading(),
      imageBuilder: (context, image) {
        return Image(
          image: image,
          fit: fit,
        );
      },
      errorWidget: (context, url, error) {
        return InkWell(
          onTap: () {
            GenDialog.show(
              context,
              GenAlert.serverError(context),
              showClose: true,
            );
          },
          child: const Icon(Icons.error_outline_outlined),
        );
      },
    );
  }
}
