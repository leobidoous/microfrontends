import '../../../core.dart';
import '../../domain/failures/default_errors.dart';

class ConnectivityService implements IConnectivityService {
  final IConnectivityDriver driver;

  ConnectivityService({required this.driver});

  @override
  Future<Either<Failure, Unit>> isOnline() async {
    try {
      if (await driver.isOnline) return const Right(unit);

      throw ConnectionError(message: 'Você está offline');
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ConnectionError(
        message: 'Erro ao recuperar informação de conexão',
      ));
    }
  }
}
