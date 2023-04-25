import 'package:equatable/equatable.dart';

abstract class IWalletException implements Exception, Equatable {
  IWalletException({this.message, this.stackTrace});

  final String? message;
  final StackTrace? stackTrace;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [message, stackTrace];
}

class UnknowRemoteDatasourceException extends IWalletException {}

class UnknowRepositoryException extends IWalletException {}

class FailureDeleteCard extends IWalletException {}
