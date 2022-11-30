import 'package:core/core.dart' show Either, Unit;

import '../entities/recent_researches_entity.dart';
import '../repositories/recent_researches_repository.dart';

abstract class IRecentResearchesUsecase {
  Future<Either<Exception, Unit>> save({
    required RecentResearchesEntity recent,
  });
  Future<Either<Exception, Unit>> delete({
    required RecentResearchesEntity recent,
  });
  Future<Either<Exception, List<RecentResearchesEntity>>> list();
}

class RecentResearchesUsecase extends IRecentResearchesUsecase {
  final IRecentResearchesRepository repository;

  RecentResearchesUsecase({required this.repository});

  @override
  Future<Either<Exception, Unit>> save({
    required RecentResearchesEntity recent,
  }) {
    return repository.save(recent: recent);
  }
  @override
  Future<Either<Exception, Unit>> delete({
    required RecentResearchesEntity recent,
  }) {
    return repository.delete(recent: recent);
  }

  @override
  Future<Either<Exception, List<RecentResearchesEntity>>> list() {
    return repository.list();
  }
}
