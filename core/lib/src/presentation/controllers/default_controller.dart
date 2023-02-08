import 'package:dartz/dartz.dart' show Either;
import 'package:flutter/foundation.dart' show ValueNotifier;
import 'package:flutter_modular/flutter_modular.dart' show Disposable;

abstract class DefaultController<E, S> extends ValueNotifier<S>
    with Disposable {
  DefaultController(super.value);

  final ValueNotifier<E?> _error = ValueNotifier(null);
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  final ValueNotifier<bool> _wasDisposed = ValueNotifier(false);

  E? get error => _error.value;
  bool get hasError => _error.value != null;
  setError(E value) {
    if (!_wasDisposed.value) {
      _error.value = value;
      notifyListeners();
    }
  }

  void clearError() {
    _error.value = null;
  }

  bool get isLoading => _loading.value;
  setLoading(bool value) {
    if (!_wasDisposed.value) {
      _loading.value = value;
      notifyListeners();
    }
  }

  S get state => value;
  update(S state, {force = false}) {
    if (!_wasDisposed.value) {
      clearError();
      _loading.value = false;
      if (value != state) {
        value = state;
        notifyListeners();
      } else {
        value = state;
        notifyListeners();
      }
    }
  }

  void execute(Future<Either<E, S>> Function() function) async {
    setLoading(true);
    await function().then((value) {
      value.fold((l) => setError(l), (r) => update(r));
    }).whenComplete(() => setLoading(false));
  }

  @override
  void dispose() {
    _error.dispose();
    _loading.dispose();
    _wasDisposed.value = true;
    super.dispose();
  }
}
