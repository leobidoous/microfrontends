import 'package:core/core.dart' show Modular, RouterObserver;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/theme.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    Modular.setObservers([RouterObserver()]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Base App',
      theme: LightTheme.theme,
      themeMode: ThemeMode.light,
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
  }
}
