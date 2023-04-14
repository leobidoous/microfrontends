import 'package:core/core.dart';

import '../../../../core/enums/bottom_nav_bar_type_enum.dart';
import '../../../app/presentation/controllers/session_controller.dart';

class HomeController extends GenController<Exception, BottomNavBarType> {
  HomeController({required this.sessionController})
      : super(BottomNavBarType.home);

  final SessionController sessionController;

  void onChangeMenuItem(BottomNavBarType item) {
    update(item);
  }
}
