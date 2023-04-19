import 'package:core/core.dart';
import 'package:flutter/material.dart' show IconData;
import 'package:pay/pay.dart';
import 'package:wallet/wallet.dart';

import '../../modules/home/presentation/routes/dashboard_routes.dart';
import '../../modules/home/presentation/routes/home_routes.dart';
import '../../modules/profile/presentation/profile_routes.dart';

enum BottomNavBarType { home, payment, wallet, profile }
// enum BottomNavBarType { home, search, payment, wallet, profile }

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

  IconData get asset {
    switch (this) {
      case BottomNavBarType.home:
        return CoreIcons.home;
      // case BottomNavBarType.search:
      //   return CoreIcons.search;
      case BottomNavBarType.payment:
        return CoreIcons.payment;
      case BottomNavBarType.wallet:
        return CoreIcons.wallet;
      case BottomNavBarType.profile:
        return CoreIcons.profile;
    }
  }

  BasePath get route {
    switch (this) {
      case BottomNavBarType.home:
        return DashboardRoutes.root;
      // case BottomNavBarType.search:
      //   return SharedRoutes.comming;
      case BottomNavBarType.payment:
        return HomeRoutes.start.concate(PayRoutes.root);
      case BottomNavBarType.wallet:
        return HomeRoutes.start.concate(WalletRoutes.root);
      case BottomNavBarType.profile:
        return ProfileRoutes.root;
    }
  }
}
