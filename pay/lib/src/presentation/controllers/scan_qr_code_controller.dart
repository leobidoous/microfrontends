import 'dart:async';

import 'package:core/core.dart';

class ScanQrCodeController extends GenController<Exception, String> {
  final CodeScanController scanController;
  late Timer timer;

  ScanQrCodeController({required this.scanController}) : super('');

  void startTime(Function() callback) {
    timer = Timer(const Duration(seconds: 60), () async {
      await callback();
      startTime(callback);
    });
  }

  @override
  void dispose() {
    timer.cancel();
    scanController.dispose();
    super.dispose();
  }
}
