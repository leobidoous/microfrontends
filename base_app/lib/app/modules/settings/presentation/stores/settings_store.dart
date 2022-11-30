import 'package:core/core.dart';

import '../../../../stores/app_store.dart';

class SettingsStore extends NotifierStore<Exception, Unit> with Disposable {
  final AppStore appStore;

  SettingsStore({required this.appStore}) : super(unit);

  Future<Either<Exception, Unit>> logout() async {
    return appStore.logout();
  }

  @override
  void dispose() {}
}
