import 'package:core/core.dart';

abstract class IRegisterFailure extends IGenFailure {}

class CouponQueryError extends IRegisterFailure {
  CouponQueryError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;

  @override
  String? get detailError => detailsMessage;
}

class SendCodeError extends IRegisterFailure {
  SendCodeError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;

  @override
  String? get detailError => detailsMessage;
}

class InvalidCodeError extends IRegisterFailure {
  InvalidCodeError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;

  @override
  String? get detailError => detailsMessage;
}

class CpfAlreadyExist extends IRegisterFailure {
  CpfAlreadyExist(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;

  @override
  String? get detailError => detailsMessage;
}

class PhoneAlreadyExist extends IRegisterFailure {
  PhoneAlreadyExist(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;

  @override
  String? get detailError => detailsMessage;
}

class EmailAlreadyExist extends IRegisterFailure {
  EmailAlreadyExist(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;

  @override
  String? get detailError => detailsMessage;
}

class UnknowError extends IRegisterFailure {
  UnknowError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;

  @override
  String? get detailError => detailsMessage;
}

class DeactivedAccountError extends IRegisterFailure {
  DeactivedAccountError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;

  @override
  String? get detailError => detailsMessage;
}

class ServerError extends IRegisterFailure {
  ServerError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;

  @override
  String? get detailError => detailsMessage;
}
