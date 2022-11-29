import 'package:core/core.dart';

import '../../../../stores/app_store.dart';

class HomeStore extends NotifierStore<Exception, Unit> with Disposable {
  final AppStore appStore;

  HomeStore({required this.appStore}) : super(unit);

  @override
  void dispose() {
    destroy();
  }
}
