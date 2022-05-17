import 'package:core/core.dart';

import '../../../../core/enums/login_type.dart';


class LoginTypeStore extends NotifierStore<Exception, LoginType> {
  LoginTypeStore() : super(LoginType.email);

  Future<void> changeLoginType(LoginType type) async {
    update(type);
  }
}