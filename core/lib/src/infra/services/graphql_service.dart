import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../domain/interfaces/either.dart';
import '../../domain/services/i_graphql_service.dart';

class GraphQlService extends IGraphQlService {
  @override
  Future<Either<Exception, Unit>> init() async {
    try {
      await initHiveForFlutter();
      debugPrint('GraphQlService iniciado com sucesso.');
      return Right(unit);
    } catch (e) {
      debugPrint('Erro ao inicializar GraphQlService.');
      return Left(Exception(e));
    }
  }
}
