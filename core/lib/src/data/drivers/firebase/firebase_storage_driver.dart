import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentSnapshot, FirebaseFirestore, Query, QuerySnapshot;
import 'package:cloud_functions/cloud_functions.dart';

import '../../../domain/entities/query_snapshot_filters_entity.dart';
import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/firebase/i_firebase_storage_driver.dart';

class FirebaseStorageDriver extends IFirebaseStorageDriver {
  final FirebaseFirestore instance;
  FirebaseStorageDriver({required this.instance});

  @override
  Future<Either<CloudFunctionDriverResponse, CloudFunctionDriverResponse>>
      cloudFunction({
    required String name,
    required dynamic data,
  }) async {
    try {
      final response =
          await FirebaseFunctions.instance.httpsCallable(name).call(
                data,
              );
      if (response.data['status'] >= 200 && response.data['status'] < 400) {
        return Right(
          CloudFunctionDriverResponse(
            statusCode: response.data['status'],
            data: response.data,
          ),
        );
      }
      return Left(
        CloudFunctionDriverResponse(
          statusCode: response.data['status'],
          data: response.data,
        ),
      );
    } catch (e, s) {
      return Left(CloudFunctionDriverResponse(data: '$e $s'));
    }
  }

  @override
  Future<Either<Exception, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getCollectionStream({
    required QuerySnapshotFiltersEntity filters,
  }) async {
    try {
      Query<Map<String, dynamic>> instance = this.instance.collection(
            filters.collection,
          );

      if (filters.whereFieldIsEqualTo != null) {
        filters.whereFieldIsEqualTo?.entries.forEach((e) {
          instance = instance.where(e.key, isEqualTo: e.value);
        });
      }

      if (filters.whereFieldIsNotEqualTo != null) {
        filters.whereFieldIsNotEqualTo?.entries.forEach((e) {
          instance = instance.where(e.key, isNotEqualTo: e.value);
        });
      }

      if (filters.whereFieldIsGreaterThan != null) {
        filters.whereFieldIsGreaterThan?.entries.forEach((e) {
          instance = instance.where(e.key, isGreaterThan: e.value);
        });
      }

      if (filters.whereFieldIsLessThan != null) {
        filters.whereFieldIsLessThan?.entries.forEach((e) {
          instance = instance.where(e.key, isLessThan: e.value);
        });
      }

      if (filters.whereFieldIsGreaterThanOrEqualTo != null) {
        filters.whereFieldIsGreaterThanOrEqualTo?.entries.forEach((e) {
          instance = instance.where(e.key, isGreaterThanOrEqualTo: e.value);
        });
      }

      if (filters.whereFieldIsLessThanOrEqualTo != null) {
        filters.whereFieldIsGreaterThanOrEqualTo?.entries.forEach((e) {
          instance = instance.where(e.key, isLessThanOrEqualTo: e.value);
        });
      }

      if (filters.whereFieldIn != null) {
        filters.whereFieldIn?.entries.forEach((e) {
          instance = instance.where(e.key, whereIn: e.value);
        });
      }

      if (filters.whereFieldNotIn != null) {
        filters.whereFieldNotIn?.entries.forEach((e) {
          instance = instance.where(e.key, whereNotIn: e.value);
        });
      }

      if (filters.orderByField.isNotEmpty) {
        instance.orderBy(
          filters.orderByField,
          descending: filters.orderDescending,
        );
      }

      if (filters.limit != null) {
        instance = instance.limit(filters.limit!);
      }

      return Right(instance.snapshots());
    } catch (e, s) {
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, QuerySnapshot<Map<String, dynamic>>>> getCollection({
    required QuerySnapshotFiltersEntity filters,
  }) async {
    try {
      Query<Map<String, dynamic>> instance = this.instance.collection(
            filters.collection,
          );

      if (filters.whereFieldIsEqualTo != null) {
        filters.whereFieldIsEqualTo?.entries.forEach((e) {
          instance = instance.where(e.key, isEqualTo: e.value);
        });
      }

      if (filters.whereFieldIsNotEqualTo != null) {
        filters.whereFieldIsNotEqualTo?.entries.forEach((e) {
          instance = instance.where(e.key, isNotEqualTo: e.value);
        });
      }

      if (filters.whereFieldIsGreaterThan != null) {
        filters.whereFieldIsGreaterThan?.entries.forEach((e) {
          instance = instance.where(e.key, isGreaterThan: e.value);
        });
      }

      if (filters.whereFieldIsLessThan != null) {
        filters.whereFieldIsLessThan?.entries.forEach((e) {
          instance = instance.where(e.key, isLessThan: e.value);
        });
      }

      if (filters.whereFieldIsGreaterThanOrEqualTo != null) {
        filters.whereFieldIsGreaterThanOrEqualTo?.entries.forEach((e) {
          instance = instance.where(e.key, isGreaterThanOrEqualTo: e.value);
        });
      }

      if (filters.whereFieldIsLessThanOrEqualTo != null) {
        filters.whereFieldIsGreaterThanOrEqualTo?.entries.forEach((e) {
          instance = instance.where(e.key, isLessThanOrEqualTo: e.value);
        });
      }

      if (filters.whereFieldIn != null) {
        filters.whereFieldIn?.entries.forEach((e) {
          instance = instance.where(e.key, whereIn: e.value);
        });
      }

      if (filters.whereFieldNotIn != null) {
        filters.whereFieldNotIn?.entries.forEach((e) {
          instance = instance.where(e.key, whereNotIn: e.value);
        });
      }

      if (filters.orderByField.isNotEmpty) {
        instance.orderBy(
          filters.orderByField,
          descending: filters.orderDescending,
        );
      }

      if (filters.limit != null) {
        instance = instance.limit(filters.limit!);
      }

      return Right(await instance.get());
    } catch (e, s) {
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, Unit>> docSet({
    required String collectionDoc,
    String? id,
    required Map<String, Object> data,
  }) async {
    try {
      await instance.collection(collectionDoc).doc(id).set(data);
      return Right(unit);
    } catch (e, s) {
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> docGet({
    required String collectionDoc,
  }) async {
    return await instance.doc(collectionDoc).get();
  }

  @override
  Future<Either<Exception, Unit>> docUpdate({
    required String collectionDoc,
    required String id,
    required Map<String, Object> data,
  }) async {
    try {
      await instance.collection(collectionDoc).doc(id).update(data);
      return Right(unit);
    } catch (e, s) {
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, Unit>> docDelete({
    required String collection,
    required String id,
  }) async {
    try {
      await instance.collection(collection).doc(id).delete();
      return Right(unit);
    } catch (e, s) {
      return Left(Exception('$e $s'));
    }
  }
}
