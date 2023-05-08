import 'package:core/core.dart';

import '../pages/belvo_webview/belvo_webview_page.dart';

class BelvoWebviewModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const BelvoWebviewPage(),
    ),
  ];
}
