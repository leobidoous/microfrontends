import '../../data/drivers/modular_dependency_manager_driver.dart';
import '../../infra/drivers/dependency_manager_driver.dart';

///
/// Provides a static access to a singleton that implements [DependencyManager]
///
mixin DM {
  static IDependencyManagerDriver get i => ModularDependencyManagerDriver.i();
}
