import 'package:core/core.dart';

import './belvo_webview_module.dart';
import './institution_module.dart';
import './transactions_module.dart';
import '../open_banking_routes.dart';
import '../pages/onboarding/onboarding_page.dart';
import '../pages/open_banking_data/open_banking_data_page.dart';
import '../pages/open_banking_page.dart';

class OpenBaningModule extends Module {

  static List<Bind> get exportedBinds => [

  ];

  @override
  final List<Bind> binds = [

    ...exportedBinds,

  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const OpenBankingPage(),
    ),
    ChildRoute(
      OpenBankingRoutes.onBoarding.path,
      child: (_, args) => const OnboardingPage(),
    ),
    ModuleRoute(
      OpenBankingRoutes.institutionList.path,
      transition: TransitionType.noTransition,
      module: InstitutionModule(),
    ),
    ModuleRoute(
      OpenBankingRoutes.belvoWebview.path,
      transition: TransitionType.noTransition,
      module: BelvoWebviewModule(),
    ),
    ChildRoute(
      OpenBankingRoutes.openBankingData.path,
      child: (_, args) => const OpenBankingDataPage(),
    ),
    ModuleRoute(
      OpenBankingRoutes.transactionList.path,
      transition: TransitionType.noTransition,
      module: TransactionModule(),
    ),
  ];
}
