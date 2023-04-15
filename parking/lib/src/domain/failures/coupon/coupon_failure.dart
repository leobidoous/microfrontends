import 'package:core/core.dart';


abstract class ICouponFailure extends IGenFailure {}

class CouponQueryError extends ICouponFailure {
  CouponQueryError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}

class ScanTimerError extends ICouponFailure {
  ScanTimerError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}
class KeyNotInformedError extends ICouponFailure {
  KeyNotInformedError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}

class CouponAlreadyRegisteredError extends ICouponFailure {
  CouponAlreadyRegisteredError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}

class PlaceNotFoundError extends ICouponFailure {
  PlaceNotFoundError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}

class InvalidCodeError extends ICouponFailure {
  InvalidCodeError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}

class UnknowError extends ICouponFailure {
  UnknowError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}
