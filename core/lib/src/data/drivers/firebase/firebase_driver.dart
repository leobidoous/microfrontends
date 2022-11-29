import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../infra/drivers/firebase/firebase_driver.dart';

class FirebaseDriver extends IFirebaseDriver {
  FirebaseDriver();

  @override
  Future<Either<Exception, Unit>> init() async {
    try {
      await Firebase.initializeApp();
      return const Right(unit);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
