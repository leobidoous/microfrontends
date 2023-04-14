
abstract class IAddCardFailures implements Exception {
  IAddCardFailures({this.message, this.detailError, this.stackTrace});
  final String? message;
  final String? detailError;
  final StackTrace? stackTrace;
}

class SaveCreditCardError extends IAddCardFailures {
  SaveCreditCardError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}

class CreateTokenFailure extends IAddCardFailures {
  CreateTokenFailure(this.messageError, {this.detailsMessage});
  final String messageError;
  final String? detailsMessage;

  @override
  String? get message => messageError;

  @override
  String? get detailError => messageError;
}
