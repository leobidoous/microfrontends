class PaginationParams {
  
  final String orderBy;
  final int page;
  final int perPage;
  final dynamic sortingOrder;
  
  PaginationParams({
    required this.orderBy,
    required this.page,
    required this.perPage,
    required this.sortingOrder,
  });

}
