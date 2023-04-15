import 'package:flutter/material.dart';
import 'package:parking/l10n/translations.dart' as parking;
import 'package:pay/l10n/translations.dart' as pay;
import 'package:shop/l10n/translations.dart' as shop;
import 'package:wallet/l10n/translations.dart' as wallet;

import '../../../l10n/translations.dart' as app;

class AppLocalizationsDelegate {
  static List<LocalizationsDelegate> get getDelegates => [
        app.Tr.delegate,
        pay.Tr.delegate,
        shop.Tr.delegate,
        wallet.Tr.delegate,
        parking.Tr.delegate,
      ];
}
