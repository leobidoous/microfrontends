import 'package:core/core.dart';

import 'pages/profile_details_page.dart';
import 'pages/profile_page.dart';
import 'profile_routes.dart';

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
    ChildRoute(
      ProfileRoutes.profileDetails.path,
      transition: TransitionType.defaultTransition,
      child: (_, args) => const ProfileDetailsPage(),
    ),
  ];
}
