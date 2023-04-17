import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../domain/interfaces/gen_controller.dart';

class QrCodeScanController extends GenController<Exception, Barcode> {
  QRViewController? scanController;
  late final Function(Barcode result) listener;

  QrCodeScanController() : super(Barcode('', BarcodeFormat.qrcode, null));

  void onAddListener(Function(Barcode result) listener) {
    this.listener = listener;
    scanController?.scannedDataStream.listen(listener);
  }

  void onQRViewCreated(QRViewController controller) {
    scanController = controller;
    update(state, force: true);
  }
}