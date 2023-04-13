
import 'package:core/core.dart';

class _PagedListConfig<T> {
  /// [nextPageKey] is the key to verify if is necessary
  /// make another [fetchNewItems] call.
  /// Is the key page, offset or similar
  _PagedListConfig({
    required this.pageKey,
    required this.pageSize,
    required this.nextPageKey,
    required this.pageIncrement,
  }) {
    _pageKey = pageKey;
    _pageSize = pageSize;
    _nextPageKey = nextPageKey;
    _pageIncrement = pageIncrement;
  }
  int pageKey;
  int pageSize;
  int nextPageKey;
  int pageIncrement;
  List<T> lastItems = List.empty(growable: true);

  late final int _pageKey;
  late final int _pageSize;
  late final int _nextPageKey;
  late final int _pageIncrement;

  bool get isLastFetch {
    return lastItems.isNotEmpty && lastItems.length < pageSize;
  }

  void reset() {
    lastItems.clear();
    pageKey = _pageKey;
    pageSize = _pageSize;
    nextPageKey = _nextPageKey;
    pageIncrement = _pageIncrement;
  }
}

class PagedListController<S, E> extends GenController<E, List<S>> {
  /// [fetchItems] is used to do a new search by new items.
  late final Future<Either<E, List<S>>> Function({required int pageKey})
      _fetchItems;

  /// [searchPercent] is the key to be used in case of a [refresh].
  final int searchPercent;

  /// [firstPageKey] is the key page, offset or similar
  ///  to be used in case of a [refresh].
  final int firstPageKey;

  /// [config] is the [PagedListController] settings
  late final _PagedListConfig<S> config;

  /// [reverse] check if the list is inverted
  late final bool reverse;

  PagedListController({
    int pageSize = 10,
    int pageIncrement = 1,
    this.firstPageKey = 0,
    this.searchPercent = 100,
    this.reverse = false,
  })  : assert(searchPercent >= 0 && searchPercent <= 100),
        super(List<S>.empty(growable: true)) {
    config = _PagedListConfig(
      nextPageKey: firstPageKey + pageIncrement,
      pageIncrement: pageIncrement,
      pageKey: firstPageKey,
      pageSize: pageSize,
    );
  }

  Future<void> refresh() async {
    if (!isLoading) {
      config.reset();
      update(List.empty(growable: true));
      await fetchNewItems(pageKey: firstPageKey);
    }
  }

  void setListener(
    Future<Either<E, List<S>>> Function({required int pageKey}) fetchItems,
  ) =>
      _fetchItems = fetchItems;

  Future<void> fetchNewItems({required int pageKey}) async {
    if (config.nextPageKey == pageKey && !hasError ||
        config.isLastFetch ||
        isLoading) {
      return;
    }
    await execute(
      () => _fetchItems(pageKey: pageKey).then((value) {
        return value.fold(
          (l) => Left(l),
          (r) {
            config.lastItems = r;
            config.pageKey += config.pageIncrement;
            if (r.isNotEmpty) {
              config.nextPageKey += config.pageIncrement;
              if (reverse) {
                return Right([...r, ...state]);
              } else {
                return Right([...state, ...r]);
              }
            }
            return Right(List<S>.empty(growable: true));
          },
        );
      }),
    );
  }
}
