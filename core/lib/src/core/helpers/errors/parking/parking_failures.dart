import 'package:equatable/equatable.dart';

abstract class IParkingException implements Exception, Equatable {
  IParkingException({this.message, this.stackTrace});

  final String? message;
  final StackTrace? stackTrace;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [message, stackTrace];
}

class CouponHasNotFoundFailure extends IParkingException {
  CouponHasNotFoundFailure({required this.response});

  final Map<String, dynamic> response;

  @override
  String? get message => response['message'];
}

class TicketHasNotFoundFailure extends IParkingException {
  TicketHasNotFoundFailure({required this.response});

  final Map<String, dynamic> response;

  @override
  String? get message => response['error'];
}

class TicketRequiredFieldsMissingFailure extends IParkingException {
  TicketRequiredFieldsMissingFailure({required this.response});

  final Map<String, dynamic> response;

  @override
  String? get message => response['error'];
}

class TicketServerFailure extends IParkingException {}
