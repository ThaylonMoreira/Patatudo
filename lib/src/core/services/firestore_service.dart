import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../shared/extensions/app_null_check_object_extension.dart';
// import '../../shared/functions/functions.dart';
// import '../user/domain/bloc/user_bloc.dart';
// import '../user/domain/entities/user_logged.dart';

class FirestoreService {
  const FirestoreService({
    required this.firestore,
    // required this.userBloc,
  });

  final FirebaseFirestore firestore;
  // final UserBloc userBloc;
  final timeoutGet = const Duration(seconds: 10);
  final timeoutEdit = const Duration(seconds: 5);
  final timeoutTransaction = const Duration(seconds: 20);

  Future<T> get<T>({
    required String collection,
    required T Function() onEmpty,
    required T Function(List<Map<String, dynamic>> docs) onData,
    required T Function(Object failure) onFailure,
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>> query)?
        queryParams,
    bool forceError = false,
  }) async {
    try {
      if (forceError) {
        // await sleep(0.5); // Temporariamente comentado
        throw FirestoreServiceError(
            FirestoreServiceErrorType.forcedError, 'forced error');
      }

      final collectionReference = firestore.collection(collection);

      final Query<Map<String, dynamic>> query = queryParams != null //
          ? queryParams(collectionReference)
          : collectionReference;

      final result = await query.get().timeout(timeoutGet);
      if (result.docs.isEmpty) {
        return onEmpty();
      }
      return onData(
          result.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList());
    } catch (error) {
      // _sendException(error: error, stack: stack, collection: collection, method: 'get'); // Temporariamente comentado
      return onFailure(error);
    }
  }

  Future<T> getById<T>({
    required String collection,
    required String id,
    required T Function(Map<String, dynamic> document) onData,
    required T Function(Object failure) onFailure,
    bool forceError = false,
  }) async {
    try {
      if (forceError) {
        // await sleep(0.5); // Temporariamente comentado
        throw FirestoreServiceError(
            FirestoreServiceErrorType.forcedError, 'forced error');
      }

      final document = await firestore
          .collection(collection)
          .doc(id)
          .get()
          .timeout(timeoutGet);
      if (document.exists) {
        return onData({
          'id': document.id,
          ...document.data()!,
        });
      }
      throw FirestoreServiceError(
          FirestoreServiceErrorType.notFound, 'id not found');
    } catch (error) {
      // _sendException(error: error, stack: stack, collection: collection, method: 'getById'); // Temporariamente comentado
      return onFailure(error);
    }
  }

  Stream<T> stream<T>({
    required String collection,
    required T Function() onEmpty,
    required T Function(List<Map<String, dynamic>> docs) onData,
    required Exception Function(Object failure) onFailure,
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>> query)?
        queryParams,
    bool forceError = false,
  }) {
    final collectionReference = firestore.collection(collection);

    final Query<Map<String, dynamic>> query = queryParams != null //
        ? queryParams(collectionReference)
        : collectionReference;

    return query.snapshots().map((snapshot) {
      if (forceError) {
        throw FirestoreServiceError(
            FirestoreServiceErrorType.forcedError, 'forced error');
      }

      if (snapshot.docs.isEmpty) {
        return onEmpty();
      }
      return onData(
          snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList());
    }).handleError((error, stack) {
      // _sendException(error: error, stack: stack, collection: collection, method: 'stream'); // Temporariamente comentado
      onFailure(error);
    });
  }

  Future<T> post<T>({
    required String collection,
    required Map<String, dynamic> document,
    required T Function(Map<String, dynamic> document) onSuccess,
    required T Function(Object failure) onFailure,
    bool forceError = false,
  }) async {
    try {
      if (forceError) {
        //await sleep(0.5);
        throw FirestoreServiceError(
            FirestoreServiceErrorType.forcedError, 'forced error');
      }

      final documentRef = firestore.collection(collection).doc();
      final changelogRef = firestore.collection('changelog').doc();

      Map<String, dynamic> newDocument = Map.from(document);
      newDocument['id'] = documentRef.id;

      await firestore.runTransaction((transaction) async {
        transaction.set(documentRef, document, SetOptions(merge: true));
        transaction.set(changelogRef, _log('create', collection, newDocument),
            SetOptions(merge: true));
      }).timeout(timeoutEdit);

      return onSuccess(newDocument);
    } catch (error) {
      /*    await _sendException(
          error: error,
          stack: stack,
          collection: collection,
          method: 'post',
          document: document); */
      return onFailure(error);
    }
  }

  Future<T> put<T>({
    required String collection,
    required String id,
    required Map<String, dynamic> document,
    required T Function(Map<String, dynamic> document) onSuccess,
    required T Function(Object failure) onFailure,
    bool forceError = false,
  }) async {
    try {
      if (forceError) {
        // await sleep(0.5); // Temporariamente comentado
        throw FirestoreServiceError(
            FirestoreServiceErrorType.forcedError, 'forced error');
      }

      final documentRef = firestore.collection(collection).doc(id);
      final changelogRef = firestore.collection('changelog').doc();

      Map<String, dynamic> updatedDocument = Map.from(document);
      updatedDocument['id'] = documentRef.id;

      await firestore.runTransaction((transaction) async {
        transaction.set(documentRef, document);
        transaction.set(
            changelogRef,
            _log('update', collection, updatedDocument),
            SetOptions(merge: true));
      }).timeout(timeoutEdit);

      return onSuccess(updatedDocument);
    } catch (error) {
      // await _sendException(error: error, stack: stack, collection: collection, method: 'put', document: document); // Temporariamente comentado
      return onFailure(error);
    }
  }

  Future<T> patch<T>({
    required String collection,
    required String id,
    required Map<String, dynamic> document,
    required T Function(Map<String, dynamic> document) onSuccess,
    required T Function(Object failure) onFailure,
    bool forceError = false,
  }) async {
    try {
      if (forceError) {
        //   await sleep(0.5);
        throw FirestoreServiceError(
            FirestoreServiceErrorType.forcedError, 'forced error');
      }

      final documentRef = firestore.collection(collection).doc(id);
      final changelogRef = firestore.collection('changelog').doc();

      Map<String, dynamic> patchedDocument = Map.from(document);
      patchedDocument['id'] = documentRef.id;

      await firestore.runTransaction((transaction) async {
        transaction.update(documentRef, document);
        transaction.set(
            changelogRef,
            _log('patch', collection, patchedDocument),
            SetOptions(merge: true));
      }).timeout(timeoutEdit);

      return onSuccess(patchedDocument);
    } catch (error) {
      /*  await _sendException(
          error: error,
          stack: stack,
          collection: collection,
          method: 'patch',
          document: document); */
      return onFailure(error);
    }
  }

  Future<T> delete<T>({
    required String collection,
    required String id,
    required Map<String, dynamic> document,
    required T Function(Map<String, dynamic> document) onSuccess,
    required T Function(Object failure) onFailure,
    bool forceError = false,
  }) async {
    try {
      if (forceError) {
        // await sleep(0.5);
        throw FirestoreServiceError(
            FirestoreServiceErrorType.forcedError, 'forced error');
      }
      final documentRef = firestore.collection(collection).doc(id);
      final changelogRef = firestore.collection('changelog').doc();

      Map<String, dynamic> deletedDocument = Map.from(document);
      deletedDocument['id'] = documentRef.id;

      await firestore.runTransaction((transaction) async {
        transaction.delete(documentRef);
        transaction.set(
            changelogRef,
            _log('delete', collection, deletedDocument),
            SetOptions(merge: true));
      }).timeout(timeoutEdit);

      return onSuccess(deletedDocument);
    } catch (error) {
      /*   await _sendException(
          error: error,
          stack: stack,
          collection: collection,
          method: 'delete',
          document: {'id': id}); */
      return onFailure(error);
    }
  }

  DocumentReference<Map<String, dynamic>> docRef(
      {required String collection, String? id}) {
    return firestore.collection(collection).doc(id);
  }

  Map<String, dynamic> _log(
    String action,
    String collection,
    Map<String, dynamic> document,
  ) {
    return {
      'action': action,
      'collection': collection,
      'document': document,
      // 'user': {'id': userBloc.currentUser.id, 'name': userBloc.currentUser.name}, // Temporariamente comentado
      'timestamp': FieldValue.serverTimestamp(),
    };
  }

  // Future<void> _sendException({ // Temporariamente comentado
  //   required dynamic error,
  //   required dynamic stack,
  //   required String collection,
  //   required String method,
  //   Map<String, dynamic>? document,
  // }) async {
  //   await captureException(error, stack, details: {
  //     'collection': collection,
  //     'method': method,
  //     if (collection != 'users' && document.isNotNull) 'document': document!,
  //   });
  // }

  // UserLogged currentUser() {
  //   return userBloc.currentUser; // Temporariamente comentado
  // }
}

class FirestoreServiceError implements Exception {
  FirestoreServiceError(this.type, this.message);
  final FirestoreServiceErrorType type;
  final String message;

  @override
  String toString() => "FirestoreServiceError: '$type -> $message'";
}

enum FirestoreServiceErrorType {
  notFound,
  forcedError,
}
