import 'package:core/core.dart';

import '../../../../core/enums/bottom_nav_bar_type_enum.dart';
import '../../../app/presentation/controllers/session_controller.dart';
import '../../domain/usecases/i_home_usecase.dart';

class HomeController extends GenController<Exception, BottomNavBarType> {
  HomeController({required this.sessionController, required this.homeUsecase})
      : super(BottomNavBarType.home);

  final SessionController sessionController;
  final IHomeUsecase homeUsecase;
  

  void onChangeMenuItem(BottomNavBarType item) {
    update(item);
  }
}
