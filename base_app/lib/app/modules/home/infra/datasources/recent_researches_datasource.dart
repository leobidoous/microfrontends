import 'package:core/core.dart' show Either, Unit;

import '../../domain/entities/recent_researches_entity.dart';

abstract class IRecentResearchesDatasource {
  Future<Either<Exception, Unit>> save({
    required RecentResearchesEntity recent,
  });
  Future<Either<Exception, Unit>> delete({
    required RecentResearchesEntity recent,
  });
  Future<Either<Exception, List<RecentResearchesEntity>>> list();
}
