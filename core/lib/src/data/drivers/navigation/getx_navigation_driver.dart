import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infra/drivers/navigation/i_navigation_arguments_driver.dart';
import '../../../infra/drivers/navigation/i_navigation_driver.dart';
import 'getx_navigation_arguments_driver.dart';

class GetxNavigationDriver implements INavigationDriver {
  final GetxNavigationArgumentsDriver _args = GetxNavigationArgumentsDriver();

  GetxNavigationDriver._();

  static GetxNavigationDriver? _instance;

  static GetxNavigationDriver i() {
    _instance ??= GetxNavigationDriver._();
    return _instance!;
  }

  @override
  INavigationArgumentsDriver get args => _args;

  @override
  bool canPop() {
    return Get.context != null ? Navigator.of(Get.context!).canPop() : false;
  }

  @override
  BuildContext get context => Get.context!;

  @override
  void pop<T extends Object>({T? response}) {
    if (response != null) {
      Get.back(result: response);
    } else {
      Get.back();
    }
  }

  @override
  Future<T?> pushNamed<T extends Object?>(
    Object path, {
    Object? arguments,
    bool? forRoot,
  }) async {
    return Get.toNamed(
      path.toString(),
      arguments: arguments,
    );
  }

  @override
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    Object path,
    bool Function(Route) predicate, {
    Object? arguments,
    bool? forRoot,
  }) async {
    return await Get.offNamedUntil(
      path.toString(),
      predicate,
      arguments: arguments,
    );
  }

  @override
  Future<T?> removeUntilAndPushNamed<T extends Object?>(
    bool Function(Route) predicate,
    Object path, {
    Object? arguments,
    bool? forRoot,
  }) async {
    popUntil(predicate);
    return pushNamed(path, arguments: arguments, forRoot: forRoot);
  }

  @override
  Future<Object?> pushReplacementNamed(
    Object path, {
    Object? arguments,
    bool? forRoot,
  }) async {
    return Get.offNamed(
      path.toString(),
      arguments: arguments,
    );
  }

  @override
  Future<void> navigate(Object path, {dynamic arguments}) async {
    throw UnimplementedError();
  }

  @override
  void popUntil(bool Function(Route) predicate) {
    Get.until(predicate);
  }

  @override
  Future<bool> maybePop<T extends Object?>([T? result]) {
    throw UnimplementedError();
  }

  @override
  List<String> get history => <String>[].map((e) => e).toList();

  @override
  void addListener(VoidCallback listener) {
    throw UnimplementedError();
  }

  @override
  void removeListener(VoidCallback listener) {
    throw UnimplementedError();
  }

  @override
  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
    Object path, {
    TO? result,
    Object? arguments,
    bool forRoot = false,
  }) {
    return Get.offAndToNamed(
      path.toString(),
      result: result,
      arguments: arguments,
    )!;
  }

  @override
  Future<T?> push<T extends Object?>(
    dynamic page, {
    bool? opaque,
    Curve? curve,
    Duration? duration,
    int? id,
    String? routeName,
    bool fullscreenDialog = false,
    dynamic arguments,
    bool preventDuplicates = true,
    bool? popGesture,
    double Function(BuildContext context)? gestureWidth,
  }) async {
    return await Get.to(
      page,
      opaque: opaque,
      curve: curve,
      duration: duration,
      id: id,
      routeName: routeName,
      fullscreenDialog: fullscreenDialog,
      arguments: arguments,
      preventDuplicates: preventDuplicates,
      popGesture: popGesture,
      gestureWidth: gestureWidth,
    );
  }
}
