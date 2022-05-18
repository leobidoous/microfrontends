import 'package:base_auth/base_auth.dart';
import 'package:core/core.dart';

import '../../../stores/app_store.dart';

class HomeStore extends NotifierStore<Exception, int> {
  final LogoutUsecase logoutUsecase;
  final AppStore appStore;

  HomeStore({required this.appStore, required this.logoutUsecase}) : super(0);

  Future<Either<Exception, Unit>> logout() async {
    return logoutUsecase();
  }
}
