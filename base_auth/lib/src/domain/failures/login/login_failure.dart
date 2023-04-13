
import 'package:core/core.dart';

abstract class ILoginFailure extends IGenFailure {}

class CouponQueryError extends ILoginFailure {
  CouponQueryError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}

class SendCodeError extends ILoginFailure {
  SendCodeError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}

class InvalidCodeError extends ILoginFailure {
  InvalidCodeError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}

class AccountNotExist extends ILoginFailure {
  AccountNotExist(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}

class UnknowError extends ILoginFailure {
  UnknowError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}

class DeactivedAccountError extends ILoginFailure {
  DeactivedAccountError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}

class ServerError extends ILoginFailure {
  ServerError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}
