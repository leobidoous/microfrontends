import 'app_configuration.dart';
import 'core/enums/flavors_enum.dart';
import 'main.dart';

Future<void> main() async {
  final configuration = AppConfiguration();
  await configuration.loadFlavor(Flavor.dev);
  setAppConfigutarion(configuration: configuration);
  await runBaseApp();
}
