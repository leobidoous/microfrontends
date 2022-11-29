import 'package:core/core.dart' show NotifierStore;

class ObscureTextStore extends NotifierStore<Exception, bool> {
  ObscureTextStore() : super(false);

  void changeShowPassword(bool value) {
    update(value);
  }
}
