abstract class IVehiclesFailures implements Exception {
  IVehiclesFailures({this.message, this.detailError, this.stackTrace});
  final String? message;
  final String? detailError;
  final StackTrace? stackTrace;
}

class SomeWrongInformationFailure extends IVehiclesFailures {
  SomeWrongInformationFailure({this.detailsMessage});
  final String? detailsMessage;

  @override
  String? get message => detailsMessage;
}

class WrongTokenFailure extends IVehiclesFailures {
  WrongTokenFailure({this.detailsMessage});
  final String? detailsMessage;

  @override
  String? get message => detailsMessage;
}

class NotFoundModelFailure extends IVehiclesFailures {
  NotFoundModelFailure({this.detailsMessage});
  final String? detailsMessage;

  @override
  String? get message => detailsMessage;
}

class UnknowFailure extends IVehiclesFailures {
  UnknowFailure({this.detailsMessage});
  final String? detailsMessage;

  @override
  String? get message => detailsMessage;
}
