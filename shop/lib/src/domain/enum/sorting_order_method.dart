enum SortingOrderMethod { asc, desc }

extension SortingOrderMethodExt on SortingOrderMethod {
  String get toJson {
    switch (this) {
      case SortingOrderMethod.asc:
        return 'ASC';
      case SortingOrderMethod.desc:
        return 'DESC';
    }
  }
}

SortingOrderMethod sortingOrderMethodFromJson(String? type) {
  switch (type) {
    case 'ASC':
      return SortingOrderMethod.asc;
    case 'DESC':
      return SortingOrderMethod.desc;
    default:
      return SortingOrderMethod.asc;
  }
}
