import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../app_routes.dart';
import '../../../../shared/presentation/views/drawer/drawer_page.dart';
import '../../../../shared/presentation/widgets/logout_confirmation.dart';
import '../home_routes.dart';
import '../stores/main_store.dart';
import '../widgets/main_app_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final store = Modular.get<MainStore>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> logout() async {
    await DefaultDialog()
        .show(
      context,
      const LogoutConfirmation(),
    )
        .then((value) {
      if (value != true) return value;
      return store.appStore.logout().then((value) {
        return value.fold(
          (l) => DefaultDialog().error(context, message: l.toString()),
          (r) => Modular.to.navigate(AppRoutes.auth.completePath),
        );
      });
    });
  }

  void _onChangNavBarIndex(int index) {
    switch (index) {
      case 0:
        store.bottomBarStore.onChangNavBarIndex(index);
        Modular.to.navigate(HomeRoutes.home.completePath);
        break;
      case 1:
        store.bottomBarStore.onChangNavBarIndex(index);
        Modular.to
            .pushNamedAndRemoveUntil(
              HomeRoutes.settings.completePath,
              ModalRoute.withName(HomeRoutes.home.completePath),
            )
            .then((value) => store.bottomBarStore.onChangNavBarIndex(0));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await logout();
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: MainAppBar(scaffoldKey: _scaffoldKey),
        resizeToAvoidBottomInset: false,
        body: const RouterOutlet(),
        drawer: DrawerPage(
        ),
        bottomNavigationBar: ScopedBuilder(
          store: store.bottomBarStore,
          onState: (_, state) {
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Theme.of(context).colorScheme.secondary,
                ),
                child: BottomNavigationBar(
                  selectedFontSize: 0,
                  enableFeedback: true,
                  onTap: _onChangNavBarIndex,
                  type: BottomNavigationBarType.shifting,
                  currentIndex: store.bottomBarStore.state,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
                  selectedItemColor: Theme.of(context).colorScheme.onBackground,
                  unselectedItemColor: Colors.grey.withOpacity(0.75),
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(CoreIcons.home, size: 20),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CoreIcons.settings, size: 20),
                      label: '',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
