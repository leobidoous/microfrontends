import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../base_style_sheet.dart';

class CodeScanView extends StatefulWidget {
  const CodeScanView({
    super.key,
    this.onEnterCodeManually,
    required this.controller,
    this.type = CodeScanType.qr,
    this.considerAppBarHeight = true,
  });

  final bool considerAppBarHeight;
  final Function()? onEnterCodeManually;
  final CodeScanController controller;
  final CodeScanType type;

  @override
  State<CodeScanView> createState() => _CodeScanViewState();
}

class _CodeScanViewState extends State<CodeScanView> {
  late final GlobalKey codeScanKey;

  @override
  void initState() {
    super.initState();
    codeScanKey = GlobalKey(debugLabel: widget.type.name);
  }

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

  List<BarcodeFormat> get formatsAllowed {
    switch (widget.type) {
      case CodeScanType.bar:
        return [BarcodeFormat.ean13, BarcodeFormat.itf];
      case CodeScanType.qr:
        return [BarcodeFormat.qrcode];
    }
  }

  QrScannerOverlayShape get overlay {
    switch (widget.type) {
      case CodeScanType.bar:
        return QrScannerOverlayShape(
          borderColor: context.colorScheme.primary,
          borderRadius: const Spacing(3).value,
          borderLength: const Spacing(5).value,
          borderWidth: const Spacing(2).value,
          overlayColor: context.colorScheme.background.withOpacity(
            .85,
          ),
          cutOutBottomOffset: 0,
          cutOutHeight:
              (context.screenHeight - context.theme.appBarTheme.appBarHeight) *
                  .75,
          cutOutWidth: context.screenWidth * .35,
        );
      case CodeScanType.qr:
        return QrScannerOverlayShape(
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
        );
    }
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
                  formatsAllowed: formatsAllowed,
                  key: codeScanKey,
                  onQRViewCreated: widget.controller.onQRViewCreated,
                  overlay: overlay,
                );
              },
            ),
            if (widget.type == CodeScanType.bar)
              Positioned(
                top: widget.considerAppBarHeight
                    ? context.theme.appBarTheme.appBarHeight
                    : 0,
                left: 0,
                right: 0,
                bottom: widget.considerAppBarHeight
                    ? context.theme.appBarTheme.appBarHeight
                    : 0,
                child: _barCodePlaceholder,
              ),
            if (widget.type == CodeScanType.qr)
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
              left: 0,
              child: SafeArea(
                child: FutureBuilder<bool?>(
                  future: widget.controller.scanController?.getFlashStatus(),
                  builder: (context, snapshot) {
                    return RotatedBox(
                      quarterTurns: widget.type == CodeScanType.bar ? 1 : 0,
                      child: Semantics(
                        button: true,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              widget.controller.scanController?.toggleFlash();
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(const Spacing(3).value),
                            child: Icon(
                              snapshot.data ?? false
                                  ? Icons.flashlight_on_outlined
                                  : Icons.flashlight_off_outlined,
                              color: context.colorScheme.onBackground,
                              size: AppFontSize.iconButton.value,
                            ),
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

  Widget get _barCodePlaceholder {
    return SafeArea(
      child: RotatedBox(
        quarterTurns: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '''Aponte a sua câmera para o código de \nbarras do tíquete do estacionamento''',
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: context.textTheme.fontWeightLight,
              ),
            ),
            Spacing(context.screenWidth * .5 / 8).vertical,
            Center(
              child: GenCard(
                onTap: widget.onEnterCodeManually,
                color: AppColorsBase.neutrla4,
                radius: context.theme.borderRadiusLG,
                padding: EdgeInsets.symmetric(
                  vertical: const Spacing(1).value,
                  horizontal: const Spacing(2).value,
                ),
                child: Text(
                  'Digitar código de barras',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
