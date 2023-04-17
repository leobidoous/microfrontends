import 'package:core/core.dart';

import '../../data/datasources/ticket_window/ticket_window_datasource.dart';
import '../../infra/repositories/ticket_window/ticket_window_repository.dart';
import '../../infra/usecases/ticket_window/ticket_window_usecase.dart';
import '../controllers/ticket_window/enter_coupon_manually_controller.dart';
import '../controllers/ticket_window/ocr_recognizer_controller.dart';
import '../controllers/ticket_window/review_photos_controller.dart';
import '../controllers/ticket_window/take_picture_controller.dart';
import '../pages/ticket_window/coupon_ocr_recognized_page.dart';
import '../pages/ticket_window/coupon_submission_result_page.dart';
import '../pages/ticket_window/enter_coupon_manually/enter_coupon_manually_page.dart';
import '../pages/ticket_window/review_photos_page.dart';
import '../pages/ticket_window/scan_ticket_or_enter_plate_page.dart';
import '../pages/ticket_window/take_picture_page.dart';
import '../pages/ticket_window/ticket_window_page.dart';
import '../routes/ticket_window_routes.dart';

class TicketWindowModule extends Module {
  @override
  final List<Bind> binds = [
    /// Ticket window
    Bind.factory<TicketWindowDatasource>(
      (i) => TicketWindowDatasource(
        graphQlClient: DM.i.get<GraphQlClientDriver>(),
        client: DM.i.get<DioClientDriver>(),
      ),
    ),
    Bind.factory<TicketWindowRepository>(
      (i) => TicketWindowRepository(
        datasource: DM.i.get<TicketWindowDatasource>(),
      ),
    ),
    Bind.factory<TicketWindowUsecase>(
      (i) => TicketWindowUsecase(
        repository: DM.i.get<TicketWindowRepository>(),
        session: DM.i.get<SessionEntity>(),
      ),
    ),

    /// Controllers
    Bind.factory<OcrRecognizerController>(
      (i) => OcrRecognizerController(usecase: DM.i.get<TicketWindowUsecase>()),
    ),
    Bind.factory<TakePictureController>((i) => TakePictureController()),
    Bind.lazySingleton<ReviewPhotosController>((i) => ReviewPhotosController()),
    Bind.factory<EnterCouponManuallyController>(
      (i) => EnterCouponManuallyController(
        usecase: DM.i.get<TicketWindowUsecase>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const TicketWindowPage(),
    ),
    ChildRoute(
      TicketWindowRoutes.takePhoto.path,
      child: (_, args) => const TakePicturePage(),
    ),
    ChildRoute(
      TicketWindowRoutes.enterCouponManually.path,
      child: (_, args) => EnterCouponManuallyPage(files: args.data['files']),
    ),
    ChildRoute(
      TicketWindowRoutes.reviewPhoto.path,
      child: (_, args) => ReviewPhotosPage(file: args.data['file']),
    ),
    ChildRoute(
      TicketWindowRoutes.couponOcrRecognized.path,
      child: (_, args) => CouponOcrRecognizedPage(files: args.data['files']),
    ),
    ChildRoute(
      TicketWindowRoutes.couponSubmissionResult.path,
      child: (_, args) => const CouponSubmissionResultPage(),
    ),
    ChildRoute(
      TicketWindowRoutes.scanTicketOrEnterPlate.path,
      child: (_, args) => const ScanTicketOrEnterPlatePage(),
    ),
  ];
}