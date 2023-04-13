import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../infra/drivers/i_dependency_manager_driver.dart';

class GetItDependencyManagerDriver implements IDependencyManagerDriver {
  static GetIt get _i => GetIt.instance;
  GetItDependencyManagerDriver._();

  static GetItDependencyManagerDriver? _instance;

  static GetItDependencyManagerDriver i() {
    _instance ??= GetItDependencyManagerDriver._();

    /// By default it's not allowed to register
    /// a type a second time.If you really need to
    /// you can disable the asserts by setting[allowReassignment]= true
    _i.allowReassignment = false;
    return _instance!;
  }

  @override
  T get<T extends Object>() {
    return _i.get<T>();
  }

  @override
  FutureOr<T> getAsync<T extends Object>() {
    return _i.getAsync<T>();
  }

  @override
  void factory<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
  }) async {
    try {
      final response = _i.registerFactory<T>(
        factoryFunc,
        instanceName: instanceName,
      );
      debugPrint('Registered ${factoryFunc.runtimeType} factory');
      return response;
    } catch (e) {
      debugPrint('Error on registering ${factoryFunc.runtimeType}: $e');
      return;
    }
  }

  @override
  void lazySingleton<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    FutureOr Function(T param)? dispose,
  }) {
    try {
      final response = _i.registerLazySingleton<T>(
        factoryFunc,
        instanceName: instanceName,
        dispose: dispose,
      );
      debugPrint('Registered ${factoryFunc.runtimeType} lazySingleton');
      return response;
    } catch (e) {
      debugPrint('Error on registering ${factoryFunc.runtimeType}: $e');
      return;
    }
  }

  @override
  void singleton<T extends Object>(
    T instance, {
    String? instanceName,
    bool? signalsReady,
    FutureOr Function(T param)? dispose,
  }) {
    try {
      final response = _i.registerSingleton<T>(
        instance,
        instanceName: instanceName,
        signalsReady: signalsReady,
        dispose: dispose,
      );
      debugPrint('Registered ${instance.runtimeType} singleton');
      return response;
    } catch (e) {
      debugPrint('Error on registering ${instance.runtimeType}: $e');
      return;
    }
  }

  @override
  FutureOr dispose<T extends Object>({
    Object? instance,
    String? instanceName,
    FutureOr Function(T p1)? disposingFunction,
  }) async {
    try {
      _i.isRegistered(instance: instance);
      final response = await _i.unregister<T>(
        instance: instance,
        instanceName: instanceName,
        disposingFunction: disposingFunction,
      );
      debugPrint('Unregister ${instance.runtimeType}');
      return response;
    } catch (e) {
      debugPrint('Error on unregistering ${instance.runtimeType}: $e');
      return;
    }
  }

  @override
  Future<void> popScope() async {
    return _i.popScope().then((value) {
      debugPrint('Pop scope to: $currentScopeName');
      return;
    });
  }

  @override
  Future<bool> popScopesTill(String name) async {
    return _i.popScopesTill(name).then((value) {
      debugPrint('Pop scope to: $currentScopeName');
      return value;
    });
  }

  @override
  void pushNewScope({String? scopeName, FutureOr Function()? dispose}) {
    _i.pushNewScope(scopeName: scopeName, dispose: dispose);
    debugPrint('Push scope to: $currentScopeName');
  }

  @override
  String get currentScopeName => _i.currentScopeName ?? '';
}
