import 'package:core/core.dart';

abstract class ICreateOrderUsecase {
  Future<Either<Exception, Unit>> call({required});
}
