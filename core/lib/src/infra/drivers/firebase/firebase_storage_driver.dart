import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../domain/entities/snapshots_filters_entity.dart';

abstract class IFirebaseStorageDriver {
  Future<Either<Exception, DocumentSnapshot?>> getDocumentKeyByValue({
    required String collection,
    required String key,
    required String value,
  });
  Future<Either<Exception, Stream<Map<String, dynamic>>>> streamDocumentsByKey({
    required SnapshotsFilters filters,
    DocumentSnapshot? doc,
  });
}
