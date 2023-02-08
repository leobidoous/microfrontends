import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:dartz/dartz.dart' show Either;


abstract class IFirebaseStorageDriver {
  Future<Either<Exception, DocumentSnapshot?>> getDocumentKeyByValue({
    required String collection,
    required String key,
    required String value,
  });
}
