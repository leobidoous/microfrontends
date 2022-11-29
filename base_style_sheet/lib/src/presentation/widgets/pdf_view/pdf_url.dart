import 'package:core/core.dart';
import 'package:flutter/material.dart';

class PDFUrl extends StatelessWidget {
  final String url;
  final TokenEntity? token;

  const PDFUrl({
    super.key,
    required this.url,
    this.token,
  });

  @override
  Widget build(BuildContext context) {
    return SfPdfViewer.network(
      url,
      canShowScrollHead: false,
      canShowHyperlinkDialog: false,
      canShowPaginationDialog: false,
      headers: token != null
          ? {
              'Authorization': 'Bearer ${token?.accessToken}',
              'x-ms-version': '2021-08-06',
            }
          : null,
    );
  }
}
