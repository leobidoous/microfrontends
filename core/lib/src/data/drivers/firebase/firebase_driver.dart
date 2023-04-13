import 'package:firebase_core/firebase_core.dart' show Firebase;

import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/firebase/i_firebase_driver.dart'
    show IFirebaseDriver;

class FirebaseDriver extends IFirebaseDriver {
  @override
  Future<Either<Exception, Unit>> init() async {
    try {
      await Firebase.initializeApp();
      return Right(unit);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
