enum DeskCardStatus { pending, initial, inProgress }

extension DeskCardStatusExt on DeskCardStatus {
  String get toJson {
    switch (this) {
      case DeskCardStatus.pending:
        return 'pending';
      case DeskCardStatus.initial:
        return 'initial';
      case DeskCardStatus.inProgress:
        return 'inProgress';
    }
  }
}

DeskCardStatus deskCardStatusFromJson(String? status) {
  switch (status) {
    case 'pending':
      return DeskCardStatus.pending;
    case 'initial':
      return DeskCardStatus.initial;
    case 'inProgress':
      return DeskCardStatus.inProgress;
    default:
      return DeskCardStatus.initial;
  }
}
