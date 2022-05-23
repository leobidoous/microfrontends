import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart'
    show Modular, RouterOutlet, SvgPicture, TripleBuilder;
import 'package:flutter/material.dart';

import '../../../../core/app_routes.dart';
import 'components/home_product_list.dart';
import 'components/home_products_filters.dart';
import 'components/home_promotion_list.dart';
import 'stores/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore store = Modular.get<HomeStore>();
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    store.productsStore.getProducts();
    store.promotionsStore.getPromotions();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: SvgPicture.asset(
            'assets/images/logo-header.svg',
            width: 168,
          ),
          backgroundColor: Colors.red,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 8),
              child: InkWell(
                onTap: logout,
                child: const Icon(Icons.exit_to_app_rounded),
              ),
            ),
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: PageView(
          controller: pageController,
          restorationId: store.toString(),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Olá, ${store.userStore.loggedUser.name}!',
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                HomePromotionList(),
                const Divider(height: 0),
                HomeProductsFilters(key: UniqueKey()),
                Expanded(child: HomeProductList()),
              ],
            ),
            const RouterOutlet(),
          ],
        ),
        bottomNavigationBar: TripleBuilder(
          store: store.bottomBarStore,
          builder: (_, triple) {
            return BottomNavigationBar(
              onTap: (index) {
                switch (index) {
                  case 0:
                    if (store.bottomBarStore.state == 0) break;
                    store.bottomBarStore.changeIndex(index);
                    pageController.jumpToPage(0);
                    Modular.to.navigate('${AppRoutes.home}/');
                    break;
                  case 1:
                    if (store.bottomBarStore.state == 1) break;
                    if (true) store.bottomBarStore.changeIndex(index);
                    pageController.jumpToPage(1);
                    Modular.to.pushNamedAndRemoveUntil(
                      '${AppRoutes.home + AppRoutes.cart}/',
                      ModalRoute.withName('${AppRoutes.home}/'),
                    );
                    break;
                  case 2:
                    if (store.bottomBarStore.state == 2) break;
                    store.bottomBarStore.changeIndex(index);
                    pageController.jumpToPage(1);
                    Modular.to.pushNamedAndRemoveUntil(
                      '${AppRoutes.home + AppRoutes.myOrders}/',
                      ModalRoute.withName('${AppRoutes.home}/'),
                    );
                    break;
                }
              },
              currentIndex: store.bottomBarStore.state,
              enableFeedback: true,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Início',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_rounded),
                  label: 'Carrinho',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.list_rounded),
                //   label: 'Pedidos',
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
