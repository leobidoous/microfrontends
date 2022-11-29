import 'package:core/core.dart'
    hide PhotoView
    show ExtendedImage, LoadState, TokenEntity;
import 'package:flutter/material.dart';

import '../loadings/default_loading.dart';
import 'photo_view.dart';
import 'widgets/photo_error.dart';

class ImageUrl extends StatelessWidget {
  final BoxFit fit;
  final String url;
  final double? width;
  final double? height;
  final TokenEntity? token;

  const ImageUrl({
    super.key,
    required this.fit,
    required this.url,
    required this.width,
    required this.height,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      url,
      fit: fit,
      cacheHeight: 1500,
      clearMemoryCacheWhenDispose: true,
      cacheMaxAge: Duration(milliseconds: token?.expiresIn ?? 5000),
      headers: token != null
          ? {
              'Authorization': 'Bearer ${token?.accessToken}',
              'x-ms-version': '2021-08-06',
            }
          : null,
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Center(
              child: DefaultLoading(
                width: (width ?? 11) > 10 ? 10 : width,
                height: (height ?? 11) > 10 ? 10 : height,
              ),
            );
          case LoadState.completed:
            return InkWell(
              onTap: () => PhotoView(
                image: state.imageProvider,
                url: url,
                token: token,
              ).show(
                context,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image(image: state.imageProvider, fit: fit),
              ),
            );
          case LoadState.failed:
            return PhotoError(error: '${state.lastException}');
        }
      },
    );
  }
}
