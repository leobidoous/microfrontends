import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../infra/drivers/firebase/firebase_storage_driver.dart';

class FirebaseStorageDriver extends IFirebaseStorageDriver with Disposable {
  final FirebaseFirestore instance;

  FirebaseStorageDriver({required this.instance});

  @override
  Future<Either<Exception, DocumentSnapshot?>> getDocumentKeyByValue({
    required String collection,
    required String key,
    required String value,
  }) async {
    try {
      final collectionReference = instance.collection(collection);
      return await collectionReference.where(key, isEqualTo: value).get().then(
        (response) {
          if (response.docs.isNotEmpty) return Right(response.docs.first);
          return const Right(null);
        },
      );
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  void dispose() {}
}
