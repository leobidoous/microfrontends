import 'dart:async';

///
/// Utility class to manage dependencies
///
// ignore: one_member_abstracts
abstract class IDependencyManagerDriver {
  ///
  /// Get an instance of type T from the DM
  ///
  T get<T extends Object>();

  ///
  /// Get an instance of type T from the DM
  ///
  FutureOr<T> getAsync<T extends Object>();

  /// Disposes an object of type T from the DM
  bool dispose<T extends Object>();
}
