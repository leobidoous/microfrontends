import 'package:core/core.dart' show Either, Unit;

import '../../domain/entities/recent_researches_entity.dart';
import '../../domain/repositories/recent_researches_repository.dart';
import '../datasources/recent_researches_datasource.dart';

class RecentResearchesRepository extends IRecentResearchesRepository {
  final IRecentResearchesDatasource datasource;

  RecentResearchesRepository({required this.datasource});

  @override
  Future<Either<Exception, Unit>> save({
    required RecentResearchesEntity recent,
  }) {
    return datasource.save(recent: recent);
  }
  @override
  Future<Either<Exception, Unit>> delete({
    required RecentResearchesEntity recent,
  }) {
    return datasource.delete(recent: recent);
  }

  @override
  Future<Either<Exception, List<RecentResearchesEntity>>> list() {
    return datasource.list();
  }
}
