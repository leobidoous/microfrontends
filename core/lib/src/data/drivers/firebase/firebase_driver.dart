import 'package:dartz/dartz.dart' show Either, Unit, Right, Left, unit;
import 'package:firebase_core/firebase_core.dart' show Firebase;

import '../../../infra/drivers/firebase/firebase_driver.dart'
    show IFirebaseDriver;

class FirebaseDriver extends IFirebaseDriver {
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
