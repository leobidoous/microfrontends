import 'package:core/core.dart';

class WalletRoutes {
  WalletRoutes({required BasePath parent}) {
    _parent = parent;
  }

  BasePath get initial => root;
  static late final BasePath _parent;

  static BasePath root = BasePath('/wallet/', _parent);
  static BasePath addCreditCard = BasePath('/add_credit_card/', root);
  static BasePath selectPaymentMethod = BasePath(
    '/select_payment_method/',
    root,
  );
}
