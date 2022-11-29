import 'dart:io';

import 'package:core/core.dart'
    show CoreIcons, MatrixFileType, SfPdfViewer, TokenEntity;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../base_style_sheet.dart';
import '../buttons/share_button.dart';
import 'pdf_url.dart';

class PDFView extends StatefulWidget {
  final TokenEntity? token;
  final String? url;
  final File? file;

  const PDFView({
    Key? key,
    this.url,
    this.file,
    this.token,
  }) : super(key: key);

  @override
  State<PDFView> createState() => _PDFViewState();

  Future<void> show(BuildContext context) async {
    await showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, animation2) {
        return PDFView(url: url, token: token);
      },
    );
  }
}

class _PDFViewState extends State<PDFView> with SingleTickerProviderStateMixin {
  late final Animation<double> animation;
  late final AnimationController controller;
  final duration = const Duration(milliseconds: 250);
  Future Function({String filename})? onScreenshot;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: duration);
    animation = Tween<double>(begin: 1, end: 0).animate(controller);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  Widget backButton(BuildContext context) {
    return IconButton(
      onPressed: Navigator.of(context).pop,
      icon: Icon(
        CoreIcons.chevronLeft,
        color: Theme.of(context).colorScheme.onBackground,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, child) {
            return FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                child: DefaultAppBar(
                  leading: backButton(context),
                  actions: [
                    widget.url != null && widget.token != null
                        ? ShareButton(
                            url: widget.url!,
                            token: widget.token!,
                            matrixFileType: MatrixFileType.pdf,
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      body: (widget.url != null)
          ? PDFUrl(url: widget.url!, token: widget.token)
          : (widget.file != null)
              ? SfPdfViewer.file(widget.file!)
              : ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.warning_rounded,
                        color: themeData.primaryColor,
                        size: 60.0,
                      ),
                      Text(
                        'Não foi possível mostrar o PDF',
                        style: themeData.textTheme.headline4,
                      ),
                    ],
                  ),
                ),
      floatingActionButton: AnimatedBuilder(
        animation: controller,
        builder: (_, child) {
          return InkWell(
            onTap: () {
              if (controller.isDismissed) {
                controller.forward();
                SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
              } else {
                controller.reverse();
                SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: themeData.colorScheme.secondary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: themeData.colorScheme.primary.withOpacity(.25),
                    spreadRadius: -1.5,
                    blurRadius: 5,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(
                controller.isDismissed
                    ? Icons.fullscreen_rounded
                    : Icons.fullscreen_exit_rounded,
                key: ObjectKey(controller.status),
                color: themeData.colorScheme.background,
              ),
            ),
          );
        },
      ),
    );
  }
}
