import 'package:core/core.dart';

class WalletRoutes {
  static const BasePath root = BasePath('/wallet/');
  static const BasePath addCreditCard = BasePath('/add_credit_card/', root);
  static const BasePath selectPaymentMethod = BasePath(
    '/select_payment_method/',
    root,
  );
}
