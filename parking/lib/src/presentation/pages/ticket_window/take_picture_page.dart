import 'dart:io';

import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../controllers/ticket_window/take_picture_controller.dart';
import '../../routes/ticket_window_routes.dart';

class TakePicturePage extends StatefulWidget {
  const TakePicturePage({super.key});

  @override
  State<TakePicturePage> createState() => _TakePicturePageState();
}

class _TakePicturePageState extends State<TakePicturePage> {
  final controller = DM.i.get<TakePictureController>();
  final duration = const Duration(milliseconds: 250);
  final cameraController = CamController();

  @override
  void initState() {
    super.initState();
    cameraController.fetchCameras().then((value) {
      cameraController.initialize();
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void takePicture() async {
    cameraController.takePicture().then((value) {
      value.fold(
        (l) {
          CustomDialog.show(
            context,
            CustomAlert.serverError(context),
            showClose: true,
          );
        },
        (pic) {
          controller.onUpdateValue(File(pic.path));
          Nav.to.pushNamed(
            TicketWindowRoutes.reviewPhoto.prevPath(),
            arguments: controller.state,
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          CameraView(
            camController: cameraController,
            child: Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: LocalTheme.dark(
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: const Spacing(2).value,
                      vertical: const Spacing(1.5).value,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: context.theme.borderRadiusMD.topLeft,
                        topRight: context.theme.borderRadiusMD.topRight,
                      ),
                      color: context.colorScheme.background.withOpacity(.5),
                    ),
                    child: SafeArea(
                      top: false,
                      child: InkWell(
                        onTap: takePicture,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 5,
                              color: context.colorScheme.onBackground,
                            ),
                          ),
                          padding: EdgeInsets.all(const Spacing(.25).value),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.colorScheme.onBackground,
                            ),
                            height: const Spacing(8).value,
                            width: const Spacing(8).value,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LocalTheme.dark(
              builder: (context) {
                return CustomAppBar(
                  backgroundColor:
                      context.colorScheme.background.withOpacity(.5),
                  toolbarHeight: context.theme.appBarTheme.appBarHeight,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
