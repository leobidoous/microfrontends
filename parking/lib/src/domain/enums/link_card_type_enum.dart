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

  VoidCallback nav(dynamic Function(LinkCardType)? arguments) {
    final args = arguments?.call(this);
    switch (this) {
      case LinkCardType.ticket:
        return () => Nav.to.pushNamed(
              TicketRoutes.ticketTracking.relativePath,
              arguments: args,
            );
      case LinkCardType.desk:
        return () => Nav.to.pushNamed(
              DeskRoutes.root.relativePath,
              arguments: args,
            );
      case LinkCardType.wallet:
        return () => Nav.to.pushNamed(
              DM.i.get<BasePath<WalletRoutes>>(),
              forRoot: true,
              arguments: args,
            );
      case LinkCardType.vehicle:
        return () => Nav.to.pushNamed(
              VehiclesRoutes.listVehicles.relativePath,
              arguments: args,
            );
    }
  }
}
