import 'package:core/core.dart' show Either, Unit;

import '../entities/recent_researches_entity.dart';

abstract class IRecentResearchesRepository {
  Future<Either<Exception, Unit>> save({
    required RecentResearchesEntity recent,
  });
  Future<Either<Exception, Unit>> delete({
    required RecentResearchesEntity recent,
  });
  Future<Either<Exception, List<RecentResearchesEntity>>> list();
}
