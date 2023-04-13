class QuerySnapshotFiltersEntity {
  int? limit;
  String collection;
  String orderByField;
  bool orderDescending;
  Map<String, List<String>>? whereFieldIn;
  Map<String, List<String>>? whereFieldNotIn;
  Map<String, String>? whereFieldIsEqualTo;
  Map<String, String>? whereFieldIsNotEqualTo;
  Map<String, String>? whereFieldIsLessThan;
  Map<String, String>? whereFieldIsGreaterThan;
  Map<String, String>? whereFieldIsLessThanOrEqualTo;
  Map<String, String>? whereFieldIsGreaterThanOrEqualTo;

  QuerySnapshotFiltersEntity({
    required this.collection,
    this.orderByField = '',
    this.orderDescending = false,
    this.limit,
    this.whereFieldIn,
    this.whereFieldNotIn,
    this.whereFieldIsEqualTo,
    this.whereFieldIsNotEqualTo,
    this.whereFieldIsLessThan,
    this.whereFieldIsGreaterThan,
    this.whereFieldIsLessThanOrEqualTo,
    this.whereFieldIsGreaterThanOrEqualTo,
  });
}
