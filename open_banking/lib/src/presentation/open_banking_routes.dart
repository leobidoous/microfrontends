import 'package:core/core.dart';

class OpenBankingRoutes {
  OpenBankingRoutes({required BasePath parent}) {
    _parent = parent;
  }

  BasePath get initial => root;
  static late final BasePath _parent;

  static BasePath root = BasePath('/open_banking/', _parent);
  static BasePath onBoarding = BasePath('/onboarding/', root);
  static BasePath institutionList = BasePath('/institution_list/', root);
  static BasePath institutionSelected = BasePath('/institution_selected/', root);
  static BasePath belvoWebview = BasePath('/belvo_webview/', root);
  static BasePath openBankingData = BasePath('/open_banking_data/', root);
  static BasePath transactionList = BasePath('/transaction_list/', root);
  static BasePath transactionDetails = BasePath(
    '/transaction_details/', 
    root,
  );

}
