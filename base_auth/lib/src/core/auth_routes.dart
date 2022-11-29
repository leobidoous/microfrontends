import 'package:core/core.dart' show BasePath;

class AuthRoutes {
  BasePath? authPath;
  AuthRoutes({required this.authPath});

  static const root = BasePath('/');
}
