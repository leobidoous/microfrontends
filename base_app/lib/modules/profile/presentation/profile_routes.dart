import 'package:core/core.dart';

import '../../home/presentation/routes/home_routes.dart';

class ProfileRoutes {
  static const BasePath root = BasePath('/profile/', HomeRoutes.start);
  static const BasePath profileDetails = BasePath('/profile_details/', root);
}
