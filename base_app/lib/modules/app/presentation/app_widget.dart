import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();

    /// Set observers on application
    Modular.setObservers(
      [
        RouterObserver(),
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig.init().config(constraints, orientation);
            return MaterialApp.router(
              title: DM.i.get<EnvironmentEntity>().appName ?? 'APP',
              theme: ThemeFactory.light(),
              darkTheme: ThemeFactory.dark(),
              themeMode: DM.i.get<EnvironmentEntity>().themeMode,
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
      },
    );
  }
}
