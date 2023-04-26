import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shop/shop.dart';
import 'package:wallet/wallet.dart';

import '../../controllers/dashboard_controller.dart';
import 'widgets/activity_list.dart';
import 'widgets/carousel_banner.dart';
import 'widgets/header_user.dart';
import 'widgets/list_main_services.dart';
import 'widgets/list_other_services.dart';
import 'widgets/list_premium_brands.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

// ignore_for_file: lines_longer_than_80_chars
class _DashboardPageState extends State<DashboardPage> {
  final controller = DM.i.get<DashboardController>();
  final transactionsController = DM.i.get<FetchTransactionsController>();
  final premiumBrandsController = DM.i.get<FetchStoreBrandsController>();

  @override
  void initState() {
    super.initState();
    controller.fetchCampaignMall();
    premiumBrandsController.fetchStoreBrands(
      params: {
        'filters': {'relevance': 'big'}
      },
    );
    transactionsController.fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.zero(),
      body: CustomScrollContent(
        padding: EdgeInsets.symmetric(vertical: const Spacing(3).value),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: const Spacing(3).value),
              child: HeaderUser(),
            ),
            Spacing.lg.vertical,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: const Spacing(3).value),
              child: ListMainServices(),
            ),
            Spacing.lg.vertical,
            CarouselBanner(controller: controller),
            Spacing.lg.vertical,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: const Spacing(3).value),
              child: _dashServices,
            ),
          ],
        ),
      ),
    );
  }

  Widget get _dashServices {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ListOtherServices(),
        Spacing.lg.vertical,
        Text(
          'Comprar por marcas',
          style: context.textTheme.bodyLarge!.copyWith(
            fontFamily: context.textTheme.secodaryFontFamily,
            fontWeight: AppFontWeight.bold.value,
          ),
        ),
        Spacing.md.vertical,
        ListPremiumBrands(controller: premiumBrandsController),
        Spacing.lg.vertical,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Atividades',
              style: context.textTheme.bodyLarge!.copyWith(
                fontFamily: context.textTheme.secodaryFontFamily,
                fontWeight: AppFontWeight.bold.value,
              ),
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                TextLink(
                  text: 'Ver mais',
                  onTap: () {
                    Nav.to.pushNamed(WalletRoutes.root, forRoot: true);
                  },
                ),
                Spacing.xxs.horizontal,
                Icon(
                  CoreIcons.rightOutline,
                  color: context.colorScheme.primary,
                  size: 14.responsiveHeight,
                ),
              ],
            ),
          ],
        ),
        Spacing.md.vertical,
        ActivityList(controller: transactionsController),
      ],
    );
  }
}
