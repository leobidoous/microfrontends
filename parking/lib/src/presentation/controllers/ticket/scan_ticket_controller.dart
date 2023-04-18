import 'dart:async';

import 'package:core/core.dart';

class ScanTicketController extends GenController<List<Exception>, String> {
  final CodeScanController scanController;
  late Timer timer;

  ScanTicketController({required this.scanController}) : super('');

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
