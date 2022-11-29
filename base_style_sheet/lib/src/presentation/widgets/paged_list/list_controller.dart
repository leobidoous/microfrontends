import 'package:core/core.dart';
import 'package:flutter/foundation.dart' show ValueNotifier;

class _ListControllerConfig {
  // bool isLastRequest
}

abstract class DefaultStore<E, S> extends ValueNotifier<S> with Disposable {
  DefaultStore(super.value);

  ValueNotifier<E?> _error = ValueNotifier(null);
  // ignore: prefer_final_fields
  ValueNotifier<bool> _loading = ValueNotifier(false);

  bool _mounted = true;

  E? get error => _error.value;
  setError(E value) {
    if (!_mounted) return;
    _error.value = value;
    notifyListeners();
  }

  void clearError() {
    if (!_mounted) return;
    _error = ValueNotifier<E?>(null);
  }

  bool get isLoading => _loading.value;
  setLoading(bool value) {
    if (!_mounted) return;
    _loading.value = value;
    notifyListeners();
  }

  S get state => value;
  update(S state) {
    if (!_mounted) return;
    value = state;
    notifyListeners();
  }

  @override
  void dispose() {
    _mounted = false;
    _error.dispose();
    _loading.dispose();
    super.dispose();
  }
}

class ListController<S, E> extends DefaultStore<E, List<S>> with Disposable {
  /// [fetchItem] is used to do a new search by new items.
  late final Future<Either<E, List<S>>> Function({
    required int offset,
  }) _fetchItem;

  /// [searchPercent] is the key to be used in case of a [refresh].
  final int searchPercent;

  /// [_offset] is the key to verify if is necessary
  /// make another [fetchNewItems] call.
  int? _offset;

  /// [config] is the [ListController] settings
  final config = _ListControllerConfig();

  ListController({this.searchPercent = 70}) : super(List.empty(growable: true));

  Future<void> refresh() async {
    setLoading(true);
    _offset = null;
    update(List.empty(growable: true));
    await fetchNewItems(offset: 0);
  }

  void setListener(
    Future<Either<E, List<S>>> Function({required int offset}) fecth,
  ) async {
    _fetchItem = fecth;
  }

  Future<void> fetchNewItems({required int offset}) async {
    if (_offset == offset && error == null) return;
    setLoading(true);
    clearError();
    _offset = offset;
    await _fetchItem(offset: offset).then((value) {
      return value.fold((l) => setError(l), (r) {
        update([...state, ...r]);
      });
    }).whenComplete(() => setLoading(false));
  }
}
