import 'dart:async';

import 'package:core/core.dart' as core
    show PhotoView, PhotoViewHeroAttributes, PhotoViewController;
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../base_style_sheet.dart';
import '../buttons/share_button.dart';

class PhotoView extends StatefulWidget {
  final ImageProvider image;
  final String? url;
  final TokenEntity? token;

  const PhotoView({Key? key, required this.image, this.url, this.token})
      : super(key: key);

  @override
  State<PhotoView> createState() => _PhotoViewState();

  Future<void> show(BuildContext context) async {
    await showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, animation2) {
        return PhotoView(
          image: image,
          url: url,
          token: token,
        );
      },
    );
  }
}

class _PhotoViewState extends State<PhotoView>
    with SingleTickerProviderStateMixin {
  late final Animation<double> animation;
  late final AnimationController controller;
  final photoController = core.PhotoViewController();
  final duration = const Duration(milliseconds: 250);
  final scaleStateController = PhotoViewScaleStateController();

  _PhotoViewState();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: duration);
    animation = Tween<double>(begin: 1, end: 0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    photoController.dispose();
    scaleStateController.dispose();
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
                            matrixFileType: MatrixFileType.image,
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: InkWell(
        onTap: () {
          if (controller.isDismissed) {
            controller.forward();
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
          } else {
            controller.reverse();
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
          }
        },
        child: core.PhotoView(
          scaleStateController: scaleStateController,
          imageProvider: widget.image,
          backgroundDecoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          controller: photoController,
          filterQuality: FilterQuality.high,
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.contained * 5,
          initialScale: PhotoViewComputedScale.contained,
          heroAttributes: core.PhotoViewHeroAttributes(tag: widget.image),
          errorBuilder: (_, error, stackTrace) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: RequestError(message: stackTrace.toString()),
              ),
            );
          },
        ),
      ),
    );
  }
}
