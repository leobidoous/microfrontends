import 'package:flutter/widgets.dart';

import 'i_navigation_arguments_driver.dart';

abstract class INavigationDriver {
  INavigationArgumentsDriver get args;

  Future<T?> pushNamed<T extends Object?>(
    Object path, {
    Object? arguments,
    bool? forRoot,
  });

  Future<Object?> pushReplacementNamed(
    Object path, {
    Object? arguments,
    bool? forRoot,
  });

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    Object path,
    bool Function(Route) predicate, {
    Object? arguments,
    bool? forRoot,
  });

  Future<T?> removeUntilAndPushNamed<T extends Object?>(
    bool Function(Route) predicate,
    Object path, {
    Object? arguments,
    bool? forRoot,
  });

  BuildContext get context;

  void navigate(Object path, {dynamic arguments});

  void pop<T extends Object>({T? response});

  void popUntil(bool Function(Route<dynamic>) predicate);

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
  });

  bool canPop();

  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
    bool forRoot = false,
  });

  Future<bool> maybePop<T extends Object?>([T? result]);

  void addListener(VoidCallback listener);

  void removeListener(VoidCallback listener);

  List<String> get history;
}
