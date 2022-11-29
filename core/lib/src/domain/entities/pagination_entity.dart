class PaginationEntity {
  int? limit;
  int? offset;
  int? count;
  String? next;
  String? previous;

  PaginationEntity({
    this.count,
    this.next,
    this.previous,
    this.offset = 0,
    this.limit = 10,
  });
}
