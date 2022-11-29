import 'dart:async';
import 'dart:developer';

import '../../../../core.dart';

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
  Future<Either<Exception, Stream<Map<String, dynamic>>>> streamDocumentsByKey({
    required SnapshotsFilters filters,
    DocumentSnapshot? doc,
  }) async {
    final collection = instance.collection(filters.collection);
    Query<Map<String, dynamic>>? query;
    if (filters.orderBy != null) {
      query = collection.orderBy(
        filters.orderBy!,
        descending: filters.descending,
      );
      if (filters.descending) {
        if (doc != null) query = query.endBeforeDocument(doc);
      } else {
        if (doc != null) query = query.startAfterDocument(doc);
      }
    }
    if (filters.limit != null) {
      query = query == null
          ? collection.limit(filters.limit!)
          : query.limit(filters.limit!);
    }

    final snapshots = query?.snapshots() ?? collection.snapshots();
    final stream = StreamController<Map<String, dynamic>>();
    late final StreamSubscription subscription;

    subscription = snapshots.listen(
      (data) {
        data.docChanges.forEach((element) async {
          try {
            subscription.pause();
            if (element.doc.exists && element.doc.data() != null) {
              // TODO: remover após realizar os testes com dispose()
              // log(
              //   '${element.doc.id} - ${element.doc.data()!['name']}: '
              //   '${element.doc.data()!['createdAt'].toDate()}',
              // );
              stream.sink.add({
                'id': element.doc.id,
                'data': element.doc.data()!,
              });
            }
            await Future.delayed(const Duration(milliseconds: 1000));
            subscription.resume();
          } catch (e) {
            stream.addError(e);
            stream.close();
          }
        });
      },
      onDone: stream.close,
      onError: (error) => stream.addError(error),
    );
    return Right(stream.stream);
  }

  @override
  void dispose() {
    log('- FirebaseStorageDriver Disposed');
  }
}
