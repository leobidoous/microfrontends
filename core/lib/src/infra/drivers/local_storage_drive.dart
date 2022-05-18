import '../../../core.dart';

abstract class ILocalStorageDriver {
  Future<Either<Exception, Unit>> createStorage();
  Future<Either<Exception, Unit>> deleteStorage();
  Future<Either<Exception, Unit>> execute({required String query});
  Future<Either<Exception, Unit>> insert({required String query});
  Future<Either<Exception, Unit>> insertAll({required String query});
  Future<Either<Exception, Unit>> select({required String query});
  Future<Either<Exception, Unit>> selectBy({required String query});
}
