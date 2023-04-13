import '../enums/pagination_type_enum.dart';

class PaginationEntity {
  int pageNumber;
  int pageSize;
  SortingOrderType sortingOrder;
  String orderBy;

  PaginationEntity({
    this.pageNumber = 1,
    this.pageSize = 10,
    this.sortingOrder = SortingOrderType.desc,
    this.orderBy = '',
  });
}
