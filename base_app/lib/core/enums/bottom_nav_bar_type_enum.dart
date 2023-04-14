import 'package:core/core.dart';
import 'package:parking/parking.dart';
import 'package:wallet/wallet.dart';

import '../../modules/home/presentation/routes/dashboard_routes.dart';
import '../../modules/home/presentation/routes/home_routes.dart';
import '../../modules/profile/presentation/profile_routes.dart';

enum BottomNavBarType { home, payment, wallet, profile }

// TODO item search foi escondido por hora, para o lançamento do app
extension BottomNavBarTypeExt on BottomNavBarType {
  String get name {
    switch (this) {
      case BottomNavBarType.home:
        return 'Início';
      // case BottomNavBarType.search:
      //   return 'Buscar';
      case BottomNavBarType.payment:
        return 'Pagar';
      case BottomNavBarType.wallet:
        return 'Carteira';
      case BottomNavBarType.profile:
        return 'Perfil';
    }
  }

  String get asset {
    switch (this) {
      case BottomNavBarType.home:
        return 'assets/icons/bottom_nav_bar/home.svg';
      // case BottomNavBarType.search:
      //   return 'assets/icons/bottom_nav_bar/search.svg';
      case BottomNavBarType.payment:
        return 'assets/icons/bottom_nav_bar/payment.svg';
      case BottomNavBarType.wallet:
        return 'assets/icons/bottom_nav_bar/wallet.svg';
      case BottomNavBarType.profile:
        return 'assets/icons/bottom_nav_bar/profile.svg';
    }
  }

  BasePath get route {
    switch (this) {
      case BottomNavBarType.home:
        return DashboardRoutes.root;
      case BottomNavBarType.payment:
        return HomeRoutes.start.concate([ParkingRoutes.root]);
      case BottomNavBarType.wallet:
        return HomeRoutes.start.concate([WalletRoutes.root]);
      case BottomNavBarType.profile:
        return ProfileRoutes.root;
    }
  }
}
