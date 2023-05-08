import 'package:core/core.dart';

import '../../data/datasources/institution/institution_datasource.dart';
import '../../infra/repositories/institution/institution_repository.dart';
import '../../infra/usecases/institution/institution_usecase.dart';
import '../controllers/institution/institution_controller.dart';
import '../open_banking_routes.dart';
import '../pages/institution/institution_list_page.dart';
import '../pages/institution/institution_selected_page.dart';

class InstitutionModule extends Module {

  static List<Bind> get exportedBinds => [
    Bind.factory<InstitutionDatasource>(
      (i) => InstitutionDatasource(
        graphQlClient: i.get<GraphQlClientDriver>(),
      ),
    ),
    Bind.factory<InstitutionRepository>(
      (i) => InstitutionRepository(
        datasource: i.get<InstitutionDatasource>(),
      ),
    ),
    Bind.factory<InstitutionUsecase>(
      (i) => InstitutionUsecase(
        repository: i.get<InstitutionRepository>(),
      ),
    ),
  ];

  @override
  final List<Bind> binds = [

    ...exportedBinds,

    Bind.factory<InstitutionController>(
      (i) => InstitutionController(usecase: i.get<InstitutionUsecase>()),
    ),

  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const InstitutionListPage(),
    ),
    ChildRoute(
      OpenBankingRoutes.institutionSelected.path,
      child: (_, args) => InstitutionSelectedPage(
        institution: args.data,
      ),
    ),
  ];
}
