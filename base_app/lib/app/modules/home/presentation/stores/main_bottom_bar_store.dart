import 'package:core/core.dart';

class MainBottomBarStore extends NotifierStore<Exception, int> {
  MainBottomBarStore() : super(0);

  Future<void> onChangNavBarIndex(int index) async {
    update(index);
  }
}
