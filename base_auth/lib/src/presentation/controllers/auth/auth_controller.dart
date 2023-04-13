
import 'package:core/core.dart';

import '../../auth_routes.dart';

class AuthController extends GenController<Exception, Unit> {
  AuthController({required this.mixpanel}) : super(unit);
  final MixPanelController mixpanel;

  void onStartButtonClick() async {
    mixpanel.sendMessage('b2c_on_click_btn_register');
    Get.toNamed(Routes.SIGN_UP_FULL_NAME);
  }

  void onSignInButtonClick() async {
    mixpanel.sendMessage('b2c_on_click_btn_register');
    Nav.to.pushNamed(AuthRoutes.login);
  }
}
