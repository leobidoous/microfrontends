import 'package:equatable/equatable.dart' show EquatableMixin;

///
/// Utility class to define a route path.
///
/// The path `/user/home` must be defined with [path] `/user` and [rootPath] `/home`.
///
/// The [completePath] getter returns the complete path, including [rootPath]
/// (if its not null).
///
/// Example:
/// - /onboarding
/// - /onboarding/steps
/// - /onboarding/steps/email
///
/// ```dart
/// // Can be defined as:
/// final root = BasePath('/onboarding');
/// final steps = BasePath('/steps', root);
/// final email = BasePath('/email', steps);
///
/// // Can be accessed with:
/// Nav.pushNamed(root);
/// Nav.pushNamed(steps);
/// Nav.pushNamed(email);
/// ```
class BasePath<T> with EquatableMixin {
  /// Current route path
  final String path;

  /// Parent route path
  final BasePath? rootPath;

  /// Creates a [BasePath]
  const BasePath(this.path, [this.rootPath]);

  /// Retrieve the complete route path
  String get completePath {
    final base = rootPath?.completePath ?? '';
    return '$base${!base.endsWith('/') ? path : path.replaceFirst('/', '')}';
  }

  BasePath<S> concate<S>(List<BasePath> childs) {
    return BasePath<S>(
      [this, ...childs.map((e) => e.relativePath)].join().replaceAll('//', '/'),
    );
  }

  /// Relative path
  String get relativePath => path.replaceFirst('/', '');

  String prevPath([int qtd = 1]) {
    String previousRelative = '../' * qtd;
    return '$previousRelative$relativePath';
  }

  @override
  String toString() => completePath;

  @override
  List<Object?> get props => [path, rootPath];
}
