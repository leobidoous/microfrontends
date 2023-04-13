import 'dart:async';

abstract class IDependencyManagerDriver {
  T get<T extends Object>();

  FutureOr<T> getAsync<T extends Object>();

  void factory<T extends Object>(
    T Function() factoryFunc, {
    String? instanceName,
  });

  void singleton<T extends Object>(
    T instance, {
    String? instanceName,
    bool? signalsReady,
    FutureOr Function(T param)? dispose,
  });

  void lazySingleton<T extends Object>(
    T Function() factoryFunc, {
    String? instanceName,
    FutureOr Function(T param)? dispose,
  });
  FutureOr dispose<T extends Object>({
    Object? instance,
    String? instanceName,
    FutureOr Function(T)? disposingFunction,
  });

  void pushNewScope({
    String? scopeName,
    FutureOr Function()? dispose,
  });

  Future<void> popScope();

  Future<bool> popScopesTill(String name);

  String get currentScopeName;
}
