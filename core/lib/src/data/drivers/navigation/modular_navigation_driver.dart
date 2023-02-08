import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../infra/drivers/navigation/navigation_arguments_driver.dart';
import '../../../infra/drivers/navigation/navigation_driver.dart';
import 'modular_navigation_arguments_driver.dart';

///
/// Navigation implementation using Modular package
///
class ModularNavigationDriver implements INavigationDriver {
  final ModularNavigationArgumentsDriver _args =
      ModularNavigationArgumentsDriver();

  ModularNavigationDriver._();

  static ModularNavigationDriver? _instance;

  ///
  /// Static instance for DM
  ///
  static ModularNavigationDriver i() {
    _instance ??= ModularNavigationDriver._();
    return _instance!;
  }

  @override
  INavigationArgumentsDriver get args => _args;

  @override
  bool canPop() {
    return Modular.to.canPop();
  }

  @override
  void pop<T extends Object>({T? response}) {
    if (response != null) {
      Modular.to.pop(response);
    } else {
      Modular.to.pop();
    }
  }

  @override
  Future<T?> pushNamed<T extends Object?>(
    Object path, {
    Object? arguments,
    bool? forRoot,
  }) async {
    return Modular.to.pushNamed<T?>(
      path.toString(),
      arguments: arguments,
      forRoot: forRoot ?? false,
    );
  }

  @override
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    Object path,
    bool Function(Route) predicate, {
    Object? arguments,
    bool? forRoot,
  }) async {
    return Modular.to.pushNamedAndRemoveUntil<T>(
      path.toString(),
      predicate,
      arguments: arguments,
      forRoot: forRoot ?? false,
    );
  }

  @override
  Future<Object?> pushReplacementNamed(
    Object path, {
    Object? arguments,
    bool? forRoot,
  }) {
    return Modular.to.pushReplacementNamed<dynamic, dynamic>(
      path.toString(),
      arguments: arguments,
      forRoot: forRoot ?? false,
    );
  }

  @override
  Future<void> navigate(Object path, {dynamic arguments}) async {
    return Modular.to.navigate(path.toString(), arguments: arguments);
  }

  @override
  void popUntil(bool Function(Route) predicate) {
    Modular.to.popUntil(predicate);
  }

  @override
  Future<bool> maybePop<T extends Object?>([T? result]) {
    return Modular.to.maybePop(result);
  }

  @override
  List<String> get history =>
      Modular.to.navigateHistory.map((e) => e.name).toList();

  @override
  void addListener(VoidCallback listener) {
    Modular.to.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    Modular.to.removeListener(listener);
  }

  @override
  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
    Object path, {
    TO? result,
    Object? arguments,
    bool forRoot = false,
  }) {
    return Modular.to.popAndPushNamed(
      path.toString(),
      result: result,
      arguments: arguments,
      forRoot: forRoot,
    );
  }

  @override
  Future<T?> push<T extends Object?>(Route<T> route) async {
    return Modular.to.push(route);
  }
  
  @override
  String get initialRoute => Modular.initialRoute;
}
