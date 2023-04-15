import 'package:core/core.dart';

abstract class IParkingDashboardFailures extends IGenFailure {}

class NoTicketFoundError extends IParkingDashboardFailures {
  NoTicketFoundError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}

class UnknowError extends IParkingDashboardFailures {
  UnknowError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}

class ServerError extends IParkingDashboardFailures {
  ServerError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}
