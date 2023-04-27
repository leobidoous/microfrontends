import 'package:core/core.dart';
import 'ticket_window_module.dart';

import '../../data/datasources/desk/desk_datasource.dart';
import '../../infra/repositories/desk/desk_repository.dart';
import '../../infra/usecases/desk/desk_usecase.dart';
import '../controllers/gen_desk/fetch_faq_controller.dart';
import '../controllers/gen_desk/gen_desk_controller.dart';
import '../pages/desk/gen_desk_page.dart';
import '../routes/ticket_window_routes.dart';

class GenDeskModule extends Module {
  @override
  final List<Bind> binds = [
    /// Gen Desk
    Bind.factory<DeskDatasource>(
      (i) => DeskDatasource(
        client: i.get<DioClientDriver>(),
        storageDriver: i.get<FirebaseStorageDriver>(),
        baseUrl: i.get<EnvironmentEntity>().baseUrlParking,
      ),
    ),
    Bind.factory<DeskRepository>(
      (i) => DeskRepository(datasource: i.get<DeskDatasource>()),
    ),
    Bind.factory<DeskUsecase>(
      (i) => DeskUsecase(
        repository: i.get<DeskRepository>(),
        session: i.get<SessionEntity>(),
      ),
    ),

    /// Controllers
    Bind.lazySingleton<FetchFAQController>(
      (i) => FetchFAQController(usecase: i.get<DeskUsecase>()),
    ),
    Bind.lazySingleton<GenDeskController>(
      (i) => GenDeskController(usecase: i.get<DeskUsecase>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const GenDeskPage(),
    ),
    ModuleRoute(TicketWindowRoutes.root.path, module: TicketWindowModule()),
  ];
}
