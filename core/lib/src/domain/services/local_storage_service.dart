
import '../../../core.dart';

abstract class ILocalStorageService {
  Future<Either<Exception, void>> createStorage();
  Future<Either<Exception, void>> deleteStorage();
  Future<Either<Exception, void>> clearStorage();
}
