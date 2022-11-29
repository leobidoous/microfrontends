import 'dart:io';

import 'package:core/core.dart' show SvgPicture, TokenEntity;
import 'package:flutter/material.dart';

import '../../../../base_style_sheet.dart';

class DefaultPDF extends StatelessWidget {
  final File? file;
  final BoxFit fit;
  final String? url;
  final String? asset;
  final double? width;
  final double? height;
  final TokenEntity? token;
  final BorderRadius? radius;
  final bool enableGestures;
  final VoidCallback? onTapItem;

  const DefaultPDF({
    Key? key,
    this.url,
    this.file,
    this.width,
    this.height,
    this.radius,
    this.asset,
    this.fit = BoxFit.contain,
    this.enableGestures = true,
    this.token,
    this.onTapItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return DefaultCard(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          onTap: () {
            if (file != null) {
              PDFView(file: file).show(context);
            } else if (url != null) {
              PDFView(url: url, token: token).show(context);
            }
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: themeData.colorScheme.onBackground,
            ),
            child: SizedBox.expand(
              child: SvgPicture.asset(
                'assets/images/logos/thumbnail_card_pdf.svg',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
