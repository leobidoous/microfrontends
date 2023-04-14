import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:wallet/wallet.dart';

import '../../controllers/dashboard_controller.dart';
import '../../controllers/notifications_controller.dart';
import 'widgets/header_user.dart';
import 'widgets/list_activity.dart';
import 'widgets/list_banners.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final controller = DM.i.get<DashboardController>();
  final notificationsController = DM.i.get<NotificationsController>();
  final transactionsController = DM.i.get<FetchTransactionsController>();

  @override
  void initState() {
    super.initState();
    controller.fetchCampaignMall();
    notificationsController.fetchNotifications();
    transactionsController.fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenAppBar.zero(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(16),
          //   child: GenButton.text(
          //     text: 'Recarga',
          //     onPressed: () {
          //       Nav.to.pushNamed(PaymentRoutes.recharge);
          //     },
          //   ),
          // ),
          Expanded(
            child: GenScrollContent(
              padding: EdgeInsets.all(const Spacing(2).value),
              child: Column(
                children: [
                  Column(
                    children: [
                      HeaderUser(),
                      Spacing.lg.vertical,
                      // TODO: Isso ficou comentado para o lançamento do app, resolver isso depois
                      //ListMainServicesWidgets(),
                      // Spacing.lg.vertical,
                      ListBanners(controller: controller),
                      //Spacing.lg.vertical,
                      //const ListOtherServicesWidgets(),
                      // Spacing.md.vertical,
                      // Center(
                      //   child: Icon(
                      //     GenIcons.downOutline,
                      //     color: AppColorsBase.textButtonColor,
                      //     size: AppFontSize.titleMedium.value,
                      //   ),
                      // ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TODO: Isso ficou comentado porque o serviço não está pronto e deve entrar no ar apenas com a tribo shop
                      // Text(
                      //   'Marcas Premiuns',
                      //   style: context.textTheme.bodyLarge!.copyWith(
                      //     fontFamily: context.textTheme.secodaryFontFamily,
                      //     fontWeight: AppFontWeight.bold.value,
                      //   ),
                      // ),
                      // Spacing.md.vertical,
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     SizedBox(
                      //       width: 50,
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           const CircleAvatar(
                      //             radius: 25.0,
                      //             backgroundImage: NetworkImage(
                      //               'https://via.placeholder.com/50',
                      //             ),
                      //             backgroundColor: Colors.transparent,
                      //           ),
                      //           Spacing.xs.vertical,
                      //           Text(
                      //             'Nike',
                      //             textAlign: TextAlign.center,
                      //             style: context.textTheme.bodySmall!.copyWith(
                      //               fontWeight: AppFontWeight.light.value,
                      //               color: AppColorsBase.neutrla5,
                      //               fontSize: 10,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 50,
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           const CircleAvatar(
                      //             radius: 25.0,
                      //             backgroundImage: NetworkImage(
                      //               'https://via.placeholder.com/50',
                      //             ),
                      //             backgroundColor: Colors.transparent,
                      //           ),
                      //           Spacing.xs.vertical,
                      //           Text(
                      //             'Adidas',
                      //             textAlign: TextAlign.center,
                      //             style: context.textTheme.bodySmall!.copyWith(
                      //               fontWeight: AppFontWeight.light.value,
                      //               color: AppColorsBase.neutrla5,
                      //               fontSize: 10,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 50,
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           const CircleAvatar(
                      //             radius: 25.0,
                      //             backgroundImage: NetworkImage(
                      //               'https://via.placeholder.com/50',
                      //             ),
                      //             backgroundColor: Colors.transparent,
                      //           ),
                      //           Spacing.xs.vertical,
                      //           Text(
                      //             'Chili Beans',
                      //             textAlign: TextAlign.center,
                      //             style: context.textTheme.bodySmall!.copyWith(
                      //               fontWeight: AppFontWeight.light.value,
                      //               color: AppColorsBase.neutrla5,
                      //               fontSize: 10,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 50,
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           const CircleAvatar(
                      //             radius: 25.0,
                      //             backgroundImage: NetworkImage(
                      //               'https://via.placeholder.com/50',
                      //             ),
                      //             backgroundColor: Colors.transparent,
                      //           ),
                      //           Spacing.xs.vertical,
                      //           Text(
                      //             'Fila',
                      //             textAlign: TextAlign.center,
                      //             style: context.textTheme.bodySmall!.copyWith(
                      //               fontWeight: AppFontWeight.light.value,
                      //               color: AppColorsBase.neutrla5,
                      //               fontSize: 10,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 50,
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           const CircleAvatar(
                      //             radius: 25.0,
                      //             backgroundImage: NetworkImage(
                      //               'https://via.placeholder.com/50',
                      //             ),
                      //             backgroundColor: Colors.transparent,
                      //           ),
                      //           Spacing.xs.vertical,
                      //           Text(
                      //             'Hugo Boss',
                      //             textAlign: TextAlign.center,
                      //             style: context.textTheme.bodySmall!.copyWith(
                      //               fontWeight: AppFontWeight.light.value,
                      //               color: AppColorsBase.neutrla5,
                      //               fontSize: 10,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Spacing.sm.vertical,
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     SizedBox(
                      //       width: 50,
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           const CircleAvatar(
                      //             radius: 25.0,
                      //             backgroundImage: NetworkImage(
                      //               'https://via.placeholder.com/50',
                      //             ),
                      //             backgroundColor: Colors.transparent,
                      //           ),
                      //           Spacing.xs.vertical,
                      //           Text(
                      //             'Kopenhagen',
                      //             textAlign: TextAlign.center,
                      //             style: context.textTheme.bodySmall!.copyWith(
                      //               fontWeight: AppFontWeight.light.value,
                      //               color: AppColorsBase.neutrla5,
                      //               fontSize: 10,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 50,
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           const CircleAvatar(
                      //             radius: 25.0,
                      //             backgroundImage: NetworkImage(
                      //               'https://via.placeholder.com/50',
                      //             ),
                      //             backgroundColor: Colors.transparent,
                      //           ),
                      //           Spacing.xs.vertical,
                      //           Text(
                      //             'Outback',
                      //             textAlign: TextAlign.center,
                      //             style: context.textTheme.bodySmall!.copyWith(
                      //               fontWeight: AppFontWeight.light.value,
                      //               color: AppColorsBase.neutrla5,
                      //               fontSize: 10,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 50,
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           const CircleAvatar(
                      //             radius: 25.0,
                      //             backgroundImage: NetworkImage(
                      //               'https://via.placeholder.com/50',
                      //             ),
                      //             backgroundColor: Colors.transparent,
                      //           ),
                      //           Spacing.xs.vertical,
                      //           Text(
                      //             'Tommy Hilfiger',
                      //             textAlign: TextAlign.center,
                      //             style: context.textTheme.bodySmall!.copyWith(
                      //               fontWeight: AppFontWeight.light.value,
                      //               color: AppColorsBase.neutrla5,
                      //               fontSize: 10,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 50,
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           const CircleAvatar(
                      //             radius: 25.0,
                      //             backgroundImage: NetworkImage(
                      //               'https://via.placeholder.com/50',
                      //             ),
                      //             backgroundColor: Colors.transparent,
                      //           ),
                      //           Spacing.xs.vertical,
                      //           Text(
                      //             'Lacoste',
                      //             textAlign: TextAlign.center,
                      //             style: context.textTheme.bodySmall!.copyWith(
                      //               fontWeight: AppFontWeight.light.value,
                      //               color: AppColorsBase.neutrla5,
                      //               fontSize: 10,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 50,
                      //       height: 80,
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           CircleAvatar(
                      //             radius: 14.0,
                      //             backgroundColor:
                      //                 AppColorsBase.textButtonColor,
                      //             child: Icon(
                      //               GenIcons.rightOutline,
                      //               color: AppColorsBase.kWhite,
                      //               size: AppFontSize.titleMedium.value,
                      //             ),
                      //           ),
                      //           Spacing.xs.vertical,
                      //           Text(
                      //             'Ver mais',
                      //             textAlign: TextAlign.center,
                      //             style: context.textTheme.bodySmall!.copyWith(
                      //               fontWeight: AppFontWeight.medium.value,
                      //               color: AppColorsBase.textButtonColor,
                      //               fontSize: 10,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      //Spacing.lg.vertical,
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: const Color(0xFFC9C9C9),
                      //     borderRadius:
                      //         BorderRadius.circular(const Spacing(0.5).value),
                      //   ),
                      //   width: double.infinity,
                      //   height: 180,
                      //   child: const Center(
                      //     child: Text('Divulgar campanhas'),
                      //   ),
                      // ),
                      // Spacing.lg.vertical,
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
                          Semantics(
                            button: true,
                            child: InkWell(
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  const TextLink(
                                    text: 'Ver mais',
                                  ),
                                  Spacing.xxs.horizontal,
                                  Icon(
                                    GenIcons.rightOutline,
                                    color: context.colorScheme.primary,
                                    size: 14.responsiveHeight,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacing.md.vertical,
                      ListActivity(controller: transactionsController),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
