import 'package:core/core.dart';

class AppController extends DefaultController<Exception, Unit> {
  UserEntity? _user;

  AppController() : super(unit);

  UserEntity get user => _user!;
  set user(UserEntity user) {
    _user = user;
  }
}
