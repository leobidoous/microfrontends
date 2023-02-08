import 'package:core/core.dart';

import 'main.dart';
import 'modules/app/presentation/app_configuration.dart';

Future<void> main() async {
  final appConfiguration = AppConfiguration();
  await appConfiguration.loadFlavor(Flavor.dev);
  await runBaseApp(appConfiguration: appConfiguration);
}
