abstract class DefaultFailures implements Exception {
  String get message;

  @override
  String toString() {
    return (message.isEmpty)
        ? runtimeType.toString()
        : '$runtimeType: $message';
  }
}

class DioErrorFailure implements DefaultFailures {
  DioErrorFailure({required this.error});
  final String error;

  @override
  String get message => error;
}
