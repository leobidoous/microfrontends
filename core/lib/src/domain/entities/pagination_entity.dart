class PaginationEntity {
  int pageNumber;
  int pageSize;
  int totalRecords;
  int pagesRemaining;

  PaginationEntity({
    this.pageNumber = 1,
    this.pageSize = 10,
    this.totalRecords = 0,
    this.pagesRemaining = 0,
  });
}
