import 'package:core/core.dart';

class UserStore extends NotifierStore<Exception, Object> with Disposable {
  UserStore() : super(Object());

  @override
  LoggedUserEntity get state => super.state as LoggedUserEntity;

  void onChangeUser(LoggedUserEntity user) => update(user);
  @override
  void dispose() {
    destroy();
  }
}
