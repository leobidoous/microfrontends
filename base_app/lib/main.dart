import 'dart:async';
import 'dart:developer';

import 'package:core/core.dart' show FirebaseCrashlytics, ModularApp;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app_configuration.dart';

late final AppConfiguration appConfiguration;

void setAppConfigutarion({required AppConfiguration configuration}) {
  appConfiguration = configuration;
}

Future<void> runBaseApp() async {
  return runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    await _configureNotifications();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
  }, (error, stackTrace) async {
    if (kDebugMode) {
      log('App error: $error');
    }
    await FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

Future<void> _configureNotifications() async {
  await localNotificationsService.init().then((value) {
    value.fold(
      (l) async {
        if (kDebugMode) {
          log(
            'Erro ao inicializar local notifications '
            'na `runBaseApp`: ${l.toString()}',
          );
        }
      },
      (r) => null,
    );
  });
  await firebaseDriver.init().then((value) {
    value.fold(
      (l) {
        if (kDebugMode) {
          log(
            'Erro ao inicializar firebase '
            'em `runBaseApp`: ${l.toString()}',
          );
        }
      },
      (r) => null,
    );
  });
}
