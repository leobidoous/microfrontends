import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentSnapshot, QuerySnapshot;

import '../../../domain/entities/query_snapshot_filters_entity.dart';
import '../../../domain/interfaces/either.dart';

class CloudFunctionDriverResponse {
  final dynamic data;
  final int? statusCode;
  String? statusMessage;

  CloudFunctionDriverResponse({
    required this.data,
    this.statusCode,
    this.statusMessage,
  });
}

abstract class IFirebaseStorageDriver {
  Future<Either<CloudFunctionDriverResponse, CloudFunctionDriverResponse>>
      cloudFunction({
    required String name,
    required dynamic data,
  });

  Future<Either<Exception, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getCollectionStream({
    required QuerySnapshotFiltersEntity filters,
  });

  Future<Either<Exception, QuerySnapshot<Map<String, dynamic>>>> getCollection({
    required QuerySnapshotFiltersEntity filters,
  });

  Future<Either<Exception, Unit>> docSet({
    required String collectionDoc,
    required Map<String, Object> data,
   String? id,
  });

  Future<DocumentSnapshot<Map<String, dynamic>>> docGet({
    required String collectionDoc,
  });

  Future<Either<Exception, Unit>> docUpdate({
    required String collectionDoc,
    required String id,
    required Map<String, Object> data,
  });

  Future<Either<Exception, Unit>> docDelete({
    required String collection,
    required String id,
  });
}
