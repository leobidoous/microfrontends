import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';

import '../../infra/drivers/dependency_manager_driver.dart';


///
/// Dependency manager implementation with Modular package
///
class ModularDependencyManagerDriver implements IDependencyManagerDriver {
  ModularDependencyManagerDriver._();

  static ModularDependencyManagerDriver? _instance;

  ///
  /// Static instance for DM
  ///
  static ModularDependencyManagerDriver i() {
    _instance ??= ModularDependencyManagerDriver._();

    return _instance!;
  }

  @override
  T get<T extends Object>() {
    return Modular.get<T>();
  }

  @override
  bool dispose<T extends Object>() {
    return Modular.dispose<T>();
  }

  @override
  FutureOr<T> getAsync<T extends Object>() {
    return Modular.getAsync<T>();
  }
}
