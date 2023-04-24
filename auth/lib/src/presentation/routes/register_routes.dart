import 'package:core/core.dart';

import '../../../auth.dart';

class RegisterRoutes {
  static BasePath root = BasePath('/register/', AuthRoutes.root);
  static BasePath validateEmail = BasePath('/validate_email/', root);
}
