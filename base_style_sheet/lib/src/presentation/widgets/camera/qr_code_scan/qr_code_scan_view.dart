import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../containers/local_theme.dart';

class QrCodeScanView extends StatefulWidget {
  final bool considerAppBarHeight;
  final QrCodeScanController controller;

  const QrCodeScanView({
    super.key,
    this.considerAppBarHeight = true,
    required this.controller,
  });

  @override
  State<QrCodeScanView> createState() => _QrCodeScanViewState();
}

class _QrCodeScanViewState extends State<QrCodeScanView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the
  // camera if the platform is android, or resume the
  //camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      widget.controller.scanController?.pauseCamera();
    }
    widget.controller.scanController?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return LocalTheme.dark(
      builder: (context) {
        return Stack(
          fit: StackFit.expand,
          children: [
            ValueListenableBuilder(
              valueListenable: widget.controller,
              builder: (context, state, child) {
                return QRView(
                  key: qrKey,
                  onQRViewCreated: widget.controller.onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: context.colorScheme.primary,
                    borderRadius: const Spacing(3).value,
                    borderLength: const Spacing(5).value,
                    borderWidth: const Spacing(2).value,
                    overlayColor: context.colorScheme.background.withOpacity(
                      .85,
                    ),
                    cutOutBottomOffset: 0,
                    cutOutHeight: context.screenWidth * .75,
                    cutOutWidth: context.screenWidth * .75,
                  ),
                );
              },
            ),
            Positioned(
              top: widget.considerAppBarHeight
                  ? context.theme.appBarTheme.appBarHeight
                  : 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(const Spacing(2).value),
                  child: Text(
                    'Aponte sua câmera para o QR Code do cupom fiscal',
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: context.textTheme.fontWeightLight,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SafeArea(
                child: FutureBuilder<bool?>(
                  future: widget.controller.scanController?.getFlashStatus(),
                  builder: (context, snapshot) {
                    return Opacity(
                      opacity: snapshot.data == null ? .5 : 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            widget.controller.scanController?.toggleFlash();
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(const Spacing(3).value),
                          child: Icon(
                            snapshot.data ?? true
                                ? Icons.flashlight_on_outlined
                                : Icons.flashlight_off_outlined,
                            color: context.colorScheme.onBackground,
                            size: AppFontSize.iconButton.value * 1.5,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
