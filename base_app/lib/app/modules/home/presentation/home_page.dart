import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart' show Modular, TripleBuilder;
import 'package:flutter/material.dart';

import '../../../../core/app_routes.dart';
import '../../../../core/enums/app_theme_type.dart';
import 'components/home_product_list.dart';
import 'components/home_promotion_list.dart';
import 'stores/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore store = Modular.get<HomeStore>();

  @override
  void initState() {
    super.initState();
    store.productsStore.getProducts();
    store.promotionsStore.getPromotions();
  }

  void logout() {
    store.logout().then((value) {
      value.fold(
        (l) => DefaultDialog().show(
            context,
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(l.toString()),
            ),
            showClose: true),
        (r) => Modular.to.navigate(
          '${AppRoutes.auth}/',
          arguments: '${AppRoutes.home}/',
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.red,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12, left: 8),
            child: InkWell(
              onTap: () {
                switch (store.appStore.themeStore.state) {
                  case AppThemeType.dark:
                    store.appStore.themeStore
                        .changeThemeType(AppThemeType.light);
                    break;
                  case AppThemeType.light:
                    store.appStore.themeStore
                        .changeThemeType(AppThemeType.dark);
                    break;
                }
              },
              child: const Icon(Icons.change_circle_rounded),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text('Olá, ${store.userStore.loggedUser.name}'),
          ),
          HomePromotionList(),
          const SizedBox(height: 12),
          Expanded(child: HomeProductList()),
        ],
      ),
      bottomNavigationBar: TripleBuilder(
        store: store.bottomBarStore,
        builder: (_, triple) {
          return BottomNavigationBar(
            onTap: store.bottomBarStore.changeIndex,
            currentIndex: store.bottomBarStore.state,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Início',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_rounded),
                label: 'Carrinho',
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: logout,
        child: const Icon(Icons.exit_to_app_rounded),
      ),
    );
  }
}
