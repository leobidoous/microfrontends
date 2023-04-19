abstract class IGenFailure implements Exception {
  IGenFailure({this.message, this.detailError, this.stackTrace});
  final String? message;
  final String? detailError;
  final StackTrace? stackTrace;
}
