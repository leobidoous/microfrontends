import 'dart:developer';

import 'package:core/core.dart'
    show
        FirebaseAnalytics,
        FirebaseAnalyticsObserver,
        FirebaseNotificationsDriver,
        Modular,
        RouterObserver,
        ScopedBuilder;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/themes/theme.dart';
import 'stores/app_store.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final store = Modular.get<AppStore>();
  final firebaseNotifications = Modular.get<FirebaseNotificationsDriver>();

  Future<void> _subscribeToTopic() async {
    [
    ].map(
      (element) async => await firebaseNotifications.subscribeToTopic(
        topic: element,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    store.themeStore.getStorageTheme();

    /// Configure Firebase functions
    firebaseNotifications.configure().then((value) async {
      await _subscribeToTopic();
      await firebaseNotifications.getToken().then((value) {
        value.fold(
          (l) => null,
          (r) => kDebugMode ? log('Firebase Token: $r') : null,
        );
      });
    });

    /// Set observers on application
    Modular.setObservers(
      [
        RouterObserver(),
        FirebaseAnalyticsObserver(analytics: Modular.get<FirebaseAnalytics>()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder(
      store: store.themeStore,
      onState: (_, state) {
        return MaterialApp.router(
          title: 'APP',
          theme: LightTheme.theme,
          darkTheme: DarkTheme.theme,
          // showPerformanceOverlay: true,
          themeMode: store.themeStore.state,
          debugShowCheckedModeBanner: false,
          locale: const Locale('pt', 'BR'),
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          routerDelegate: Modular.routerDelegate,
          supportedLocales: const [Locale('pt', 'BR')],
          routeInformationParser: Modular.routeInformationParser,
          builder: (_, child) {
            return MediaQuery(
              data: MediaQuery.of(_).copyWith(textScaleFactor: 1.0),
              child: GestureDetector(
                onTap: () => FocusScope.of(_).requestFocus(FocusNode()),
                child: child ?? const SizedBox(),
              ),
            );
          },
        );
      },
    );
  }
}
