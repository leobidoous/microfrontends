import 'package:core/core.dart';

import '../../data/datasources/coupon/coupon_datasource.dart';
import '../../infra/repositories/coupon/coupon_repository.dart';
import '../../infra/usecases/coupon/coupon_usecase.dart';
import '../../infra/usecases/parking/parking_usecase.dart';
import '../controllers/coupon/coupon_submit_controller.dart';
import '../controllers/coupon/coupons_list_controller.dart';
import '../controllers/coupon/scan_coupon_controller.dart';
import '../pages/coupon/coupon_details_page.dart';
import '../pages/coupon/coupon_submit_page.dart';
import '../pages/coupon/coupon_successfully_registered_page.dart';
import '../pages/coupon/coupons_list_page.dart';
import '../pages/coupon/scan_coupon_page.dart';
import '../routes/coupon_routes.dart';

class CouponModule extends Module {
  @override
  final List<Bind> binds = [
    /// Coupon
    Bind.factory<CouponDatasource>(
      (i) => CouponDatasource(
        client: i.get<DioClientDriver>(),
        storageDriver: DM.i.get<FirebaseStorageDriver>(),
        baseUrl: i.get<EnvironmentEntity>().baseUrlParking,
      ),
    ),
    Bind.factory<CouponRepository>(
      (i) => CouponRepository(datasource: DM.i.get<CouponDatasource>()),
    ),
    Bind.factory<CouponUsecase>(
      (i) => CouponUsecase(
        session: DM.i.get<SessionEntity>(),
        repository: DM.i.get<CouponRepository>(),
      ),
    ),

    /// Controllers
    Bind.factory<CouponsListController>(
      (i) => CouponsListController(usecase: DM.i.get<CouponUsecase>()),
    ),
    Bind.factory<CouponSubmitController>(
      (i) => CouponSubmitController(
        couponUsecase: DM.i.get<CouponUsecase>(),
        parkingUsecase: DM.i.get<ParkingUsecase>(),
      ),
    ),
    Bind.factory<QrCodeScanController>((i) => QrCodeScanController()),
    Bind.factory<ScanCouponController>(
      (i) => ScanCouponController(
        couponUsecase: DM.i.get<CouponUsecase>(),
        scanController: DM.i.get<QrCodeScanController>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const ScanCouponPage(),
    ),
    ChildRoute(
      CouponRoutes.couponDetails.path,
      child: (_, args) => CouponDetailsPage(
        transaction: args.data['transaction'],
      ),
    ),
    ChildRoute(
      CouponRoutes.couponsList.path,
      child: (_, args) => CouponsListPage(
        freeParking: args.data['freeParking'],
      ),
    ),
    ChildRoute(
      CouponRoutes.couponsList.path,
      child: (_, args) => CouponsListPage(
        freeParking: args.data['freeParking'],
      ),
    ),
    ChildRoute(
      CouponRoutes.couponSubmit.path,
      child: (_, args) => CouponSubmitPage(qrcode: args.data['qrcode']),
    ),
    ChildRoute(
      CouponRoutes.couponSuccessfullyRegistered.path,
      child: (_, args) => CouponSuccessfullyRegisteredPage(
        args: CouponSuccessfullyRegisteredPageArgs(
          coupon: args.data['coupon'],
          transaction: args.data['transaction'],
        ),
      ),
    ),
  ];
}
