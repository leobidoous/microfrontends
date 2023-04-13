abstract class IGenFailure implements Exception {
  IGenFailure({this.message, this.detailError, this.stackTrace});
  final String? message;
  final String? detailError;
  final StackTrace? stackTrace;
}

class UnknowError extends IGenFailure {
  UnknowError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}

class ServerError extends IGenFailure {
  ServerError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}
