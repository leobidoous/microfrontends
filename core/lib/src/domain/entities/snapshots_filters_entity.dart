class SnapshotsFilters {
  int? limit;
  String? orderBy;
  bool descending;
  final String collection;

  SnapshotsFilters({
    this.limit,
    required this.collection,
    this.orderBy,
    this.descending = true,
  });
}
