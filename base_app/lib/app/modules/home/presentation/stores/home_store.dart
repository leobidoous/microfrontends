import 'package:core/core.dart';

import '../../domain/usecases/recent_researches_usecase.dart';

class HomeStore extends NotifierStore<Exception, Unit> with Disposable {
  final IRecentResearchesUsecase recentResearchesUsecase;

  HomeStore({
    required this.recentResearchesUsecase,
  }) : super(unit);


  @override
  void dispose() {
    destroy();
  }
}
