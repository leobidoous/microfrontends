import 'package:camera/camera.dart' as camera;
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../containers/local_theme.dart';
import '../gen_loading.dart';

class CameraView extends StatefulWidget {
  final Widget? child;
  final CamController camController;
  const CameraView({super.key, this.child, required this.camController});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Colors.black),
      child: LocalTheme.dark(
        builder: (context) {
          return ValueListenableBuilder(
            valueListenable: widget.camController,
            builder: (context, value, child) {
              if (widget.camController.isLoading) {
                return Padding(
                  padding: EdgeInsets.all(const Spacing(2).value),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Iniciando câmera',
                        style: context.textTheme.bodyMedium,
                      ),
                      const GenLoading(),
                    ],
                  ),
                );
              }
              return Stack(
                fit: StackFit.expand,
                children: [
                  if (widget.camController.cameraController != null)
                    camera.CameraPreview(
                      widget.camController.cameraController!,
                    ),
                  if (widget.child != null) widget.child!,
                ],
              );
            },
          );
        },
      ),
    );
  }
}
