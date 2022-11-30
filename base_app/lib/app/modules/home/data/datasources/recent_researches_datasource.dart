import 'package:core/core.dart'
    show Either, IPreferencesStorageDriver, Left, Right, Unit;

import '../../domain/entities/recent_researches_entity.dart';
import '../../infra/datasources/recent_researches_datasource.dart';
import '../../infra/models/recent_researches_model.dart';

enum RecentResearchesKeys { recents }

class RecentResearchesDatasource extends IRecentResearchesDatasource {
  final IPreferencesStorageDriver storageDriver;

  RecentResearchesDatasource({required this.storageDriver});

  @override
  Future<Either<Exception, List<RecentResearchesEntity>>> list() async {
    return await storageDriver
        .getStringListByKey(key: RecentResearchesKeys.recents.name)
        .then((value) {
      return value.fold(
        (l) => Left(l),
        (r) {
          return Right(
            r.map((e) => RecentResearchesModel.fromJson(e).toEntity()).toList(),
          );
        },
      );
    });
  }

  @override
  Future<Either<Exception, Unit>> save({
    required RecentResearchesEntity recent,
  }) async {
    final recents = await storageDriver.getStringListByKey(
      key: RecentResearchesKeys.recents.name,
    );
    return recents.fold(
      (l) => Left(l),
      (r) async {
        try {
          final recents = List<String>.from(r, growable: true);
          recents.removeWhere((e) {
            return RecentResearchesModel.fromJson(e).toEntity().term ==
                recent.term;
          });
          recents.insert(0, RecentResearchesModel.fromEntity(recent).toJson());
          return await storageDriver.setStringListByKey(
            key: RecentResearchesKeys.recents.name,
            value: recents,
          );
        } catch (e) {
          return Left(Exception('Erro ao salvar busca recente'));
        }
      },
    );
  }

  @override
  Future<Either<Exception, Unit>> delete({
    required RecentResearchesEntity recent,
  }) async {
    final recents = await storageDriver.getStringListByKey(
      key: RecentResearchesKeys.recents.name,
    );
    return recents.fold(
      (l) => Left(l),
      (r) async {
        try {
          final recents = List<String>.from(r, growable: true);
          recents.removeWhere((e) {
            return RecentResearchesModel.fromJson(e).toEntity().term ==
                recent.term;
          });
          return await storageDriver.setStringListByKey(
            key: RecentResearchesKeys.recents.name,
            value: recents,
          );
        } catch (e) {
          return Left(Exception('Erro ao deletar busca recente'));
        }
      },
    );
  }
}
