import 'package:core/core.dart';

import 'profile_page.dart';

class ProfileModule extends Module {
  @override
  final List<Bind> binds = [
    /// Stores
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const ProfilePage(),
    ),
  ];
}
