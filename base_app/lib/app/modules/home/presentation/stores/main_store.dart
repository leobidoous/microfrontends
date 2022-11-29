import 'package:core/core.dart';

import '../../../../stores/app_store.dart';
import 'main_bottom_bar_store.dart';

class MainStore extends NotifierStore<Exception, Unit> with Disposable {
  final MainBottomBarStore bottomBarStore;
  final AppStore appStore;

  MainStore({
    required this.bottomBarStore,
    required this.appStore,
  }) : super(unit);

  @override
  void dispose() {
    bottomBarStore.destroy();
    destroy();
  }
}
