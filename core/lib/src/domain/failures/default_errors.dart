abstract class Failure implements Exception {
  String get message;
}

class ConnectionError extends Failure {
  @override
  final String message;
  ConnectionError({required this.message});
}

class InternalError extends Failure {
  @override
  final String message;
  InternalError({required this.message});
}

class DownloadFileError extends Failure {
  @override
  final String message;
  DownloadFileError({required this.message});
}
