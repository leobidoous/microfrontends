import 'dart:async';

import 'package:core/core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'modules/app/presentation/app_configuration.dart';
import 'modules/app/presentation/app_module.dart';
import 'modules/app/presentation/app_widget.dart';

Future<void> configureLogs({required IFirebaseDriver firebaseDriver}) async {
  /// Initialize Firebase
  await firebaseDriver.init().then((value) {
    value.fold(
      (l) {
        debugPrint(
          'Erro ao inicializar firebase '
          'em `runBaseApp`: ${l.toString()}',
        );
      },
      (r) => debugPrint('Firebase iniciado com sucesso.'),
    );
  });
  FirebaseInAppMessaging.instance.setAutomaticDataCollectionEnabled(true);
}

Future<void> configureNotifications({
  required ILocalNotificationsService localNotificationsService,
  required IFirebaseNotificationsDriver firebaseNotificationsDriver,
}) async {
  await Future.wait(
    [
      /// Initialize Local Notifications
      localNotificationsService.init().then((value) {
        value.fold(
          (l) {
            debugPrint(
              'Erro ao inicializar local notifications '
              'na `runBaseApp`: ${l.toString()}',
            );
          },
          (r) => debugPrint('Local Notification iniciado com sucesso.'),
        );
      }),

      /// Configure Firebase Notifications
      firebaseNotificationsDriver.configure().then((value) {
        value.fold(
          (l) {
            debugPrint(
              'Erro ao configurar firebase '
              'em `runBaseApp`: ${l.toString()}',
            );
          },
          (r) => debugPrint('Firebase configurado com sucesso.'),
        );
      }),
    ],
  );
}

Future<void> runBaseApp({required AppConfiguration appConfiguration}) async {
  return runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    await Future.wait([
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]),
      appConfiguration.getAppInfo(),
      appConfiguration.getDeviceInfo(),
      configureLogs(firebaseDriver: GlobalConfigs.firebaseDriver),
    ]);

    await Future.wait([
      configureNotifications(
        localNotificationsService: GlobalConfigs.localNotificationsService,
        firebaseNotificationsDriver: GlobalConfigs.firebaseNotificationsDriver,
      ),
      GlobalConfigs.crashlyticsDriver.init(),
      GlobalConfigs.graphQlService.init(),
      GlobalConfigs.locationService.init(),
    ]);

    return runApp(
      ModularApp(
        module: AppModule(appConfiguration: appConfiguration),
        child: const AppWidget(),
      ),
    );
  }, (error, stackTrace) async {
    try {
      await GlobalConfigs.crashlyticsDriver.setError(
        exception: error,
        stackTrace: stackTrace,
      );
      debugPrint('Error captured by crashlyticsDriver: $error');
    } catch (e) {
      debugPrint('Error in runZonedGuarded: $e');
    }
  });
}
