import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_localizations_delegate.dart';
import 'controllers/theme_controller.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final themeController = DM.i.get<ThemeController>();

  @override
  void initState() {
    super.initState();
    Modular.setNavigatorKey(GlobalKey<NavigatorState>());

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
            final size = Size(constraints.maxWidth, constraints.maxHeight);
            return ValueListenableBuilder<ThemeMode>(
              valueListenable: themeController,
              builder: (context_, state, child) {
                return ScreenUtilInit(
                  designSize: size,
                  minTextAdapt: true,
                  splitScreenMode: true,
                  builder: (context, child) {
                    return MaterialApp.router(
                      title: DM.i.get<EnvironmentEntity>().appName ?? 'APP',
                      themeMode: state,
                      theme: ThemeFactory.light(),
                      darkTheme: ThemeFactory.dark(),
                      debugShowCheckedModeBanner:
                          DM.i.get<EnvironmentEntity>().flavor != Flavor.prod,
                      locale: const Locale('pt', 'BR'),
                      localizationsDelegates: [
                        ...AppLocalizationsDelegate.getDelegates,
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
                            onTap: () => FocusScope.of(_).requestFocus(
                              FocusNode(),
                            ),
                            child: child ?? const SizedBox(),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
