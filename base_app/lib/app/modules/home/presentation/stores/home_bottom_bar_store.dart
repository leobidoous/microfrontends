import 'package:core/core.dart';


class HomeBottomBarStore extends NotifierStore<Exception, int> {
  HomeBottomBarStore() : super(0);

  Future<void> changeIndex(int index) async {
    update(index);
  }
}
