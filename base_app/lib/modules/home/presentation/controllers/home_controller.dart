import 'package:core/core.dart';

import '../../../app/presentation/controllers/session_controller.dart';

class HomeController extends GenController<Exception, Unit> {
  final SessionController sessionController;

  HomeController({required this.sessionController}) : super(unit);
}
