import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entities/customer_entity.dart';
import '../../../domain/entities/firebase_token_result_entity.dart';
import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/firebase/i_firebase_auth_driver.dart';
import '../../../infra/models/claims_model.dart';
import '../../../infra/models/customer_model.dart';

class FirebaseAuthDriver extends IFirebaseAuthDriver {
  final FirebaseAuth instance;

  FirebaseAuthDriver({required this.instance});

  @override
  Future<Either<Exception, Unit>> logout() async {
    try {
      await instance.signOut();
      return Right(unit);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  CustomerEntity? get getCurrentUser {
    try {
      // final response = instance.currentUser!;
      return CustomerModel.fromMap({});
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Either<Exception, FirebaseTokenResultEntity>> getFirebaseTokenResult({
    bool forceRefresh = false,
  }) async {
    try {
      final response = await instance.currentUser!.getIdTokenResult(
        forceRefresh,
      );
      return Right(
        FirebaseTokenResultEntity(
          claims: ClaimsModel.fromMap(response.claims ?? {}),
          token: response.token ?? '',
          signInProvider: response.signInProvider ?? '',
        ),
      );
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Unit>> signInWithCustomToken({
    required String token,
  }) async {
    try {
      await instance.signInWithCustomToken(token);
      return Right(unit);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
