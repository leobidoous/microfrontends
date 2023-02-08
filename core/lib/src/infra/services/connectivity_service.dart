import 'package:dartz/dartz.dart' show Either, Unit, Right, unit, Left;

import '../../domain/services/connectivity_service.dart'
    show IConnectivityService;
import '../drivers/connectivity_driver.dart' show IConnectivityDriver;

class ConnectivityService implements IConnectivityService {
  final IConnectivityDriver driver;

  ConnectivityService({required this.driver});

  @override
  Future<Either<Exception, Unit>> isOnline() async {
    try {
      if (await driver.isOnline) return const Right(unit);

      throw Exception('Você está offline.');
    } catch (e) {
      return Left(
        Exception('Erro ao recuperar informação de conexão: $e'),
      );
    }
  }
}
