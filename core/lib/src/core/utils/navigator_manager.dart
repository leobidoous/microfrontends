import '../../data/drivers/navigation/modular_navigation_driver.dart';
import '../../infra/drivers/navigation/navigation_driver.dart';

///
/// Provides a static access to a singleton that implements [Navigation]
///
class Nav {
  static INavigationDriver get to => ModularNavigationDriver.i();
}
