import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:wallet/wallet.dart';

import '../../../l10n/translations.dart';
import '../../presentation/routes/desk_routes.dart';
import '../../presentation/routes/ticket_routes.dart';
import '../../presentation/routes/vehicles_routes.dart';

enum LinkCardType { ticket, desk, wallet, vehicle }

extension LinkCardTypeExt on LinkCardType {
  Color get color {
    switch (this) {
      case LinkCardType.ticket:
        return AppColorsBase.error1;
      case LinkCardType.desk:
        return AppColorsBase.primaryColor;
      case LinkCardType.wallet:
        return AppColorsBase.success2;
      case LinkCardType.vehicle:
        return AppColorsBase.kWarning;

      default:
        return AppColorsBase.error0;
    }
  }

  List<String> texts(BuildContext context) {
    switch (this) {
      case LinkCardType.ticket:
        return [
          Tr.of(context).ticketTitle,
          Tr.of(context).ticketDescription,
        ];
      case LinkCardType.desk:
        return [
          Tr.of(context).balconyTitle,
          Tr.of(context).balconyDescription,
        ];
      case LinkCardType.wallet:
        return [
          Tr.of(context).walletTitle,
          Tr.of(context).walletDescription,
        ];
      case LinkCardType.vehicle:
        return [
          Tr.of(context).vehicleTitle,
          Tr.of(context).vehicleDescription,
        ];

      default:
        return ['', ''];
    }
  }

  List<IconData> icons(BuildContext context) {
    switch (this) {
      case LinkCardType.ticket:
        return [
          GenIcons.scancodeOutline,
          GenIcons.barCode,
        ];
      case LinkCardType.desk:
        return [
          GenIcons.informationCircleOutline,
          GenIcons.scancodeOutline,
        ];
      case LinkCardType.wallet:
        return [
          GenIcons.money,
          GenIcons.scancodeOutline,
        ];
      case LinkCardType.vehicle:
        return [
          GenIcons.carSide,
          GenIcons.scancodeOutline,
        ];

      default:
        return [
          GenIcons.scancodeOutline,
          GenIcons.scancodeOutline,
        ];
    }
  }

  Function get nav {
    switch (this) {
      case LinkCardType.ticket:
        return () => Nav.to.pushNamed(TicketRoutes.ticketTracking.relativePath);
      case LinkCardType.desk:
        return () => Nav.to.pushNamed(DeskRoutes.root.relativePath);
      case LinkCardType.wallet:
        final route = '../start/${WalletRoutes.root.relativePath}';
        return () => Nav.to.pushNamed(route, forRoot: true);
      case LinkCardType.vehicle:
        return () => Nav.to.pushNamed(VehiclesRoutes.listVehicles.relativePath);
      default:
        return () {};
    }
  }
}
