import 'package:core/core.dart';

import '../../../domain/entities/desk/faq_entity.dart';
import '../../../domain/usecases/desk/i_desk_usecase.dart';

class FetchFAQController extends GenController<Exception, List<FAQEntity>> {
  final IDeskUsecase usecase;
  FetchFAQController({required this.usecase}) : super([]);

  Future<void> fetchFAQs() async {
    await execute(() => usecase.fetchFAQs());
  }
}
