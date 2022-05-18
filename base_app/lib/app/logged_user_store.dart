import 'package:core/core.dart';

class LoggedUserStore extends NotifierStore<Exception, LoggedUserEntity> {
  LoggedUserStore({required LoggedUserEntity user}) : super(user);

}
