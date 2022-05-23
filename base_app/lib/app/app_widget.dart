import 'package:core/core.dart' show Modular, RouterObserver, ScopedBuilder;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/enums/app_theme_type.dart';
import '../core/theme.dart';
import 'stores/app_store.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final AppStore store = Modular.get<AppStore>();
  @override
  void initState() {
    super.initState();
    Modular.setObservers([RouterObserver()]);
  }

  ThemeMode get getThemeMode {
    switch (store.themeStore.state) {
      case AppThemeType.dark:
        return ThemeMode.dark;
      case AppThemeType.light:
        return ThemeMode.light;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder(
      store: store.themeStore,
      onState: (_, state) {
        return MaterialApp.router(
          title: 'Base App',
          theme: LightTheme.theme,
          darkTheme: DarkTheme.theme,
          themeMode: getThemeMode,
          // showPerformanceOverlay: true,
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
