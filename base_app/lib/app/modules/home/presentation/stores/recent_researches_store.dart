import 'package:core/core.dart';

import '../../domain/entities/recent_researches_entity.dart';
import '../../domain/usecases/recent_researches_usecase.dart';

class RecentResearchesStore
    extends NotifierStore<Exception, List<RecentResearchesEntity>>
    with Disposable {
  final IRecentResearchesUsecase recentResearchesUsecase;

  RecentResearchesStore({
    required this.recentResearchesUsecase,
  }) : super([]);

  Future<void> getList() async {
    setLoading(true);
    await recentResearchesUsecase.list().then((value) {
      value.fold((l) => setError(l), (r) => update(r));
    }).whenComplete(() => setLoading(false));
  }

  Future<void> save({required RecentResearchesEntity recent}) async {
    setLoading(true);
    await recentResearchesUsecase.save(recent: recent).then((value) async {
      await getList();
    });
  }

  Future<void> remove({
    required RecentResearchesEntity recent,
  }) async {
    await recentResearchesUsecase.delete(recent: recent).then((value) async {
      await getList();
    });
  }

  @override
  void dispose() {
    destroy();
  }
}
