import 'package:auth/auth.dart';
import 'package:core/core.dart';

class AppController extends GenController<Exception, Unit> {
  AppController({
    required this.localUserUsecase,
    required this.authUsecase,
  }) : super(unit);

  late SessionEntity session;
  final IAuthUsecase authUsecase;
  final ILocalUserUsecase localUserUsecase;

  Future<Either<Exception, SessionEntity>> getSession() async {
    final sessionResponse = await localUserUsecase.getSession();
    return sessionResponse.fold(
      (l) => Left(l),
      (session) async {
        this.session = session;
        if (!authUsecase.sessionIsValid(session)) {
          await authUsecase.logout(navigateToLogin: false);
          return Left(Exception('Invalid session.'));
        }
        return Right(session);
      },
    );
  }
}
