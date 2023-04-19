import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../pay.dart';
import '../controllers/scan_qr_code_controller.dart';

class ScanQrCodePage extends StatefulWidget {
  const ScanQrCodePage({super.key});

  @override
  State<ScanQrCodePage> createState() => _ScanQrCodePageState();
}

class _ScanQrCodePageState extends State<ScanQrCodePage> {
  final controller = DM.i.get<ScanQrCodeController>();

  final tips = [
    'O QR Code deve estar completo sem rasuras ou falhas.',
    'Verifique se o QR Code não está amassado ou dobrado.',
    'Posicione o QR Code no centro para focar a câmera.',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        barrierColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        builder: (context) => _tipsContent,
      ).then((value) => setCamListener());
    });
  }

  Future<void> submitCode(String code) async {
    controller.timer.cancel();
    await Nav.to.pushNamed(PayRoutes.phoneRecharge, arguments: code);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void setCamListener() {
    controller.startTime(() async => await submitCode(''));
    controller.scanController.onAddListener((result) async {
      controller.scanController.scanController?.pauseCamera();
      await submitCode(result.code ?? '');
      controller.scanController.scanController?.resumeCamera();
    });
  }

  Widget get _tipsContent {
    return LocalTheme.dark(
      builder: (context) {
        return Scaffold(
          appBar: CustomAppBar.zero(),
          backgroundColor: context.colorScheme.background.withOpacity(
            .85,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(const Spacing(2).value),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Spacing.xxxl.vertical,
                  Text(
                    'Dicas',
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleLarge,
                  ),
                  Spacing.xxxl.vertical,
                  Expanded(
                    child: ListView.separated(
                      itemCount: tips.length,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      separatorBuilder: (_, __) => Spacing.sm.vertical,
                      itemBuilder: (_, index) {
                        return Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline_rounded,
                              color: context.colorScheme.onBackground,
                            ),
                            Spacing.sm.horizontal,
                            Expanded(
                              child: Text(
                                tips[index],
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: context.textTheme.fontWeightLight,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Spacing.sm.vertical,
                  CustomButton.text(text: 'Entendi', onPressed: Nav.to.pop),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LocalTheme.dark(
      builder: (context) {
        return Scaffold(
          extendBody: true,
          body: Stack(
            fit: StackFit.expand,
            children: [
              CodeScanView(controller: controller.scanController),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: CustomAppBar(
                  showDivider: false,
                  automaticallyImplyLeading: false,
                  toolbarHeight: context.theme.appBarTheme.appBarHeight,
                  backgroundColor: Colors.transparent,
                  actions: [
                    AppBarButton(
                      onTap: Nav.to.pop,
                      child: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
