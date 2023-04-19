import 'package:core/core.dart';

class PayRoutes {
  PayRoutes({required BasePath parent}) {
    _parent = parent;
  }

  BasePath get initial => root;
  static late final BasePath _parent;

  static BasePath root = BasePath('/pay/', _parent);
  static BasePath phoneRecharge = BasePath('/phone_recharge/', root);
  static BasePath qrCode = BasePath('/qr_code/', root);
}
