import 'package:core/core.dart' show  ModularApp;
import 'package:flutter/material.dart';

// import 'package:flutter/foundation.dart' show kDebugMode;

import 'app/app_module.dart';
import 'app/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
