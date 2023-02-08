import 'package:core/core.dart';

class AppController extends DefaultController<Exception, Unit> {
  UserEntity? _user;
  TokenEntity? _token;

  AppController() : super(unit);

  UserEntity get user => _user!;
  set user(UserEntity user) {
    _user = user;
  }

  TokenEntity get token => _token!;
  set token(TokenEntity token) {
    _token = token;
  }
}
