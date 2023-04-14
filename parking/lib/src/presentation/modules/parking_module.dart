import 'package:core/core.dart';

import '../controllers/parking_controller.dart';
import '../pages/parking_page.dart';

class ParkingModule extends Module {
  @override
  final List<Bind> binds = [
    /// Controllers
    Bind.factory<ParkingController>(
      (i) => ParkingController(session: i.get<SessionEntity>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const ParkingPage(),
    ),
  ];
}
