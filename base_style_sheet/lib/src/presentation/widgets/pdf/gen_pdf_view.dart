import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../alerts/gen_alert.dart';
import '../gen_dialog.dart';

class GenPdfView extends StatefulWidget {
  const GenPdfView({super.key, this.asset, this.url});

  final String? url;
  final String? asset;

  @override
  State<GenPdfView> createState() => _GenPdfViewState();
}

class _GenPdfViewState extends State<GenPdfView> {
  final controller = PdfViewerController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.url != null) {
      return SfPdfViewer.network(
        widget.url!,
        controller: controller,
        pageLayoutMode: PdfPageLayoutMode.continuous,
        onDocumentLoadFailed: (details) async {
          await GenDialog.show(
            context,
            GenAlert.serverError(context),
            showClose: true,
          ).then((value) => Nav.to.pop());
        },
      );
    } else if (widget.asset != null) {
      return SfPdfViewer.asset(widget.asset!);
    } else {
      return const SizedBox();
    }
  }
}
