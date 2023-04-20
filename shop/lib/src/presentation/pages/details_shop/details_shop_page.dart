import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/store_entity.dart';
import '../../controllers/details_shop/details_shop_controller.dart';

class DetailsShopPage extends StatefulWidget {
  final StoreEntity store;
  const DetailsShopPage({super.key, required this.store});

  @override
  State<DetailsShopPage> createState() => _DetailsShopPageState();
}

class _DetailsShopPageState extends State<DetailsShopPage> {
  final controller = DM.i.get<DetailsShopController>();
  @override
  void initState() {
    super.initState();
    controller.setCurrentDateTime();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String get address => '${widget.store.pointOfSale.line1}, '
      'N° ${widget.store.pointOfSale.line2}\n'
      '${widget.store.pointOfSale.neighborhood} - '
      '${widget.store.pointOfSale.city} - '
      '${widget.store.pointOfSale.state}\n'
      '${widget.store.pointOfSale.line3}';

  String get shText => 'Conheça a Loja ${widget.store.displayName} no'
      '${widget.store.storeMall.shortName}\n'
      '$address\n'
      'Contato: ${UtilsFormats.phone(widget.store.callNumber)}';

  Uri get wppUrl => Uri.parse(
        'whatsapp://send?phone=+55${widget.store.whatsappNumber}&text=$shText',
      );

  Uri get smsUrl => Uri(
        scheme: 'sms',
        path: '+55${widget.store.callNumber}',
        queryParameters: <String, String>{
          'body': Uri.encodeComponent(shText),
        },
      );

  Uri get smsTel => Uri(
        scheme: 'tel',
        path: '+55${widget.store.callNumber}'.replaceAll('Telefone: ', ''),
      );

  bool get isOpen {
    bool res = false;
    for (int i = 0; i < widget.store.openingHours.length; i++) {
      if (widget.store.openingHours[i]['weekDay'] == controller.day) {
        res = controller.verifyIsOpen(
          widget.store.openingHours[i]['open'],
          widget.store.openingHours[i]['close'],
        );
      }
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsBase.neutrla0,
      appBar: CustomAppBar(
        onBackTap: Nav.to.pop,
        title: 'Detalhes da loja',
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 174.0,
              child: Stack(
                children: [
                  Container(
                    color: const Color(0xFF000000),
                    height: 162,
                    width: context.screenWidth,
                    child: Image.network(
                      widget.store.logo,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Positioned(
                    right: const Spacing(3).value,
                    bottom: const Spacing(0).value,
                    child: Container(
                      width: 110,
                      height: 26,
                      decoration: BoxDecoration(
                        color: AppColorsBase.primary,
                        borderRadius:
                            BorderRadius.circular(const Spacing(0.5).value),
                      ),
                      child: Center(
                        child: Text(
                          isOpen ? 'Aberta' : 'Fechada',
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: AppColorsBase.neutrla0,
                            fontWeight: AppFontWeight.regular.value,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(const Spacing(3).value),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          '${widget.store.displayName}'
                          '${widget.store.storeMall.shortName}',
                          style: context.textTheme.titleMedium!.copyWith(
                            fontFamily: 'Inter',
                            fontWeight: AppFontWeight.bold.value,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          //TODO: Serviço ainda não disponível
                          /* InkWell(
                            onTap: () {
                              GenDialog.show(
                                context,
                                GenAlert.noImplementation(
                                  context,
                                ),
                                showClose: true,
                              );
                            },
                            child: Icon(
                              CoreIcons.heartOutline,
                              color: AppColorsBase.neutrla7,
                            ),
                          ), */
                          SizedBox(width: const Spacing(1).value),
                          InkWell(
                            onTap: () {
                              controller.takeScreenShoot(
                                shareableWidget(
                                  store: widget.store,
                                  address: address,
                                  height: context.screenHeight * 0.75,
                                  width: context.screenWidth,
                                  titleStyle:
                                      context.textTheme.bodyLarge!.copyWith(
                                    fontFamily: 'Inter',
                                    fontWeight: AppFontWeight.bold.value,
                                  ),
                                  bodyStyle:
                                      context.textTheme.bodyMedium!.copyWith(
                                    fontWeight: AppFontWeight.light.value,
                                    color: AppColorsBase.neutrla5,
                                  ),
                                  contactStyle:
                                      context.textTheme.bodyMedium!.copyWith(
                                    color: AppColorsBase.primary,
                                    fontWeight: AppFontWeight.light.value,
                                  ),
                                ),
                                shText,
                              );
                            },
                            child: Icon(
                              CoreIcons.sendOutline,
                              color: AppColorsBase.neutrla7,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: const Spacing(2).value),
                  Text(
                    widget.store.description,
                    style: context.textTheme.bodySmall,
                  ),
                  Visibility(
                    visible: widget.store.tags.isNotEmpty,
                    child: Column(
                      children: [
                        SizedBox(height: const Spacing(3).value),
                        TagsWidget(tags: widget.store.tags)
                      ],
                    ),
                  ),
                  SizedBox(height: const Spacing(3).value),
                  CustomCard(
                    radius: BorderRadius.circular(8),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: const Spacing(2).value,
                        vertical: const Spacing(3).value,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Endereço da loja',
                            style: context.textTheme.titleMedium!.copyWith(
                              fontFamily: 'Inter',
                              fontWeight: AppFontWeight.bold.value,
                            ),
                          ),
                          SizedBox(height: const Spacing(2).value),
                          Text(
                            address,
                            style: context.textTheme.bodySmall!.copyWith(
                              fontWeight: AppFontWeight.light.value,
                              color: AppColorsBase.neutrla5,
                            ),
                          ),
                          //TODO: Não tem serviço ainda
                          /* SizedBox(height: const Spacing(1).value),
                          Row(
                            children: [
                              Icon(
                                CoreIcons.environmentOutline,
                                color: AppColorsBase.textButtonColor,
                                size: 18,
                              ),
                              SizedBox(width: const Spacing(1).value),
                              Text(
                                '8,4km',
                                style: TextStyle(
                                  color: AppColorsBase.textButtonColor,
                                ),
                              ),
                            ],
                          ), */
                          SizedBox(height: const Spacing(4).value),
                          Text(
                            'Horário de funcionamento',
                            style: context.textTheme.titleMedium!.copyWith(
                              fontFamily: 'Inter',
                              fontWeight: AppFontWeight.bold.value,
                            ),
                          ),
                          SizedBox(height: const Spacing(2).value),
                          OpeningHoursWidget(
                            hours: widget.store.openingHours,
                          ),
                          SizedBox(height: const Spacing(4).value),
                          Text(
                            'Contato',
                            style: context.textTheme.titleMedium!.copyWith(
                              fontFamily: 'Inter',
                              fontWeight: AppFontWeight.bold.value,
                            ),
                          ),
                          SizedBox(height: const Spacing(2).value),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (await canLaunchUrl(wppUrl)) {
                                    await launchUrl(wppUrl);
                                  } else {
                                    throw 'Could not launch $wppUrl';
                                  }
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CoreIcons.whatsapp,
                                      color: AppColorsBase.primary,
                                    ),
                                    SizedBox(height: const Spacing(1).value),
                                    Text(
                                      'Whatsapp',
                                      style:
                                          context.textTheme.bodySmall!.copyWith(
                                        color: AppColorsBase.neutrla6,
                                        fontWeight: AppFontWeight.light.value,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  if (await canLaunchUrl(smsTel)) {
                                    await launchUrl(smsTel);
                                  } else {
                                    throw 'Could not launch $wppUrl';
                                  }
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CoreIcons.phone,
                                      color: AppColorsBase.primary,
                                    ),
                                    SizedBox(height: const Spacing(1).value),
                                    Text(
                                      'Telefone',
                                      style:
                                          context.textTheme.bodySmall!.copyWith(
                                        color: AppColorsBase.neutrla6,
                                        fontWeight: AppFontWeight.light.value,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //TODO: Serviço ainda não disponível
                              /* InkWell(
                                onTap: () {
                                  GenDialog.show(
                                    context,
                                    GenAlert.noImplementation(
                                      context,
                                    ),
                                    showClose: true,
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CoreIcons.contactUs,
                                      color: AppColorsBase.textButtonColor,
                                    ),
                                    SizedBox(height: const Spacing(1).value),
                                    Text(
                                      'Chat',
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
                                        color: AppColorsBase.textButtonColor,
                                        fontWeight: AppFontWeight.light.value,
                                      ),
                                    ),
                                  ],
                                ),
                              ), */
                            ],
                          ),
                          SizedBox(height: const Spacing(3).value),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Avaliações',
                                style: context.textTheme.titleMedium!.copyWith(
                                  fontFamily: 'Inter',
                                  fontWeight: AppFontWeight.bold.value,
                                ),
                              ),
                              //TODO: Não possui serviço ainda
                              /* InkWell(
                                onTap: () {
                                  GenDialog.show(
                                    context,
                                    GenAlert.noImplementation(
                                      context,
                                    ),
                                    showClose: true,
                                  );
                                },
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Text(
                                      'Ver mais',
                                      style:
                                          context.textTheme.bodySmall!.copyWith(
                                        fontWeight: AppFontWeight.regular.value,
                                        color: AppColorsBase.neutrla5,
                                      ),
                                    ),
                                    SizedBox(width: const Spacing(0.5).value),
                                    Icon(
                                      CoreIcons.rightOutline,
                                      color: AppColorsBase.neutrla5,
                                      size: 14,
                                    ),
                                  ],
                                ),
                              ), */
                            ],
                          ),
                          SizedBox(height: const Spacing(2).value),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '0.0',
                                style: context.textTheme.bodySmall!.copyWith(
                                  fontWeight: AppFontWeight.regular.value,
                                  color: AppColorsBase.neutrla5,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    CoreIcons.star,
                                    color: AppColorsBase.neutrla3,
                                    size: 16,
                                  ),
                                  SizedBox(width: const Spacing(0.5).value),
                                  Icon(
                                    CoreIcons.star,
                                    color: AppColorsBase.neutrla3,
                                    size: 16,
                                  ),
                                  SizedBox(width: const Spacing(0.5).value),
                                  Icon(
                                    CoreIcons.star,
                                    color: AppColorsBase.neutrla3,
                                    size: 16,
                                  ),
                                  SizedBox(width: const Spacing(0.5).value),
                                  Icon(
                                    CoreIcons.star,
                                    color: AppColorsBase.neutrla3,
                                    size: 16,
                                  ),
                                  SizedBox(width: const Spacing(0.5).value),
                                  Icon(
                                    CoreIcons.star,
                                    color: AppColorsBase.neutrla3,
                                    size: 16,
                                  ),
                                ],
                              ),
                              Text(
                                '(0)',
                                style: context.textTheme.bodySmall!.copyWith(
                                  fontWeight: AppFontWeight.regular.value,
                                  color: AppColorsBase.neutrla5,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: const Spacing(3).value),
                  //TODO: Não possui serviço ainda
                  /* Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Produtos recomendados',
                        style: context.textTheme.bodyLarge!.copyWith(
                          fontFamily: 'Inter',
                          fontWeight: AppFontWeight.bold.value,
                        ),
                      ),
                      InkWell(
                        onTap: () => _launchInWebViewOrVC(
                          Uri(
                            scheme: 'https',
                            host: 'store-dev.gen.com.br',
                            path:
                                'external/52032167-541f-4b82-9c23-c2c6227eb0b6/store/products',
                          ),
                        ),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Text(
                              'Ver mais',
                              style: context.textTheme.bodySmall!.copyWith(
                                fontWeight: AppFontWeight.regular.value,
                                color: AppColorsBase.neutrla5,
                              ),
                            ),
                            SizedBox(width: const Spacing(0.5).value),
                            Icon(
                              CoreIcons.rightOutline,
                              color: AppColorsBase.neutrla5,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                      // InkWell(
                      //   onTap: () => Nav.to
                      //       .pushNamed(ShopRoutes.catalogStore.completePath),
                      //   child: Flex(
                      //     direction: Axis.horizontal,
                      //     children: [
                      //       Text(
                      //         'Ver mais',
                      //         style: context.textTheme.bodySmall!.copyWith(
                      //           fontWeight: AppFontWeight.regular.value,
                      //           color: AppColorsBase.neutrla5,
                      //         ),
                      //       ),
                      //       SizedBox(width: const Spacing(0.5).value),
                      //       Icon(
                      //         CoreIcons.rightOutline,
                      //         color: AppColorsBase.neutrla5,
                      //         size: 14,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: const Spacing(2).value), */
                  /* Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: GenCard(
                          radius: BorderRadius.circular(8),
                          withShaddow: false,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: const Spacing(1).value,
                              top: const Spacing(1).value,
                              right: const Spacing(1).value,
                              bottom: const Spacing(2).value,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    GenDialog.show(
                                      context,
                                      GenAlert.noImplementation(
                                        context,
                                      ),
                                      showClose: true,
                                    );
                                  },
                                  child: Container(
                                    width: 139,
                                    height: 139,
                                    color: const Color(0xFFF5F5F5),
                                  ),
                                ),
                                SizedBox(height: const Spacing(1).value),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Title',
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
                                        fontWeight: AppFontWeight.medium.value,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        GenDialog.show(
                                          context,
                                          GenAlert.noImplementation(
                                            context,
                                          ),
                                          showClose: true,
                                        );
                                      },
                                      child: Icon(
                                        CoreIcons.heartOutline,
                                        color: AppColorsBase.neutrla7,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: const Spacing(1).value),
                                Text(
                                  'Lorem ipsum dolor sit amet',
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    fontWeight: AppFontWeight.light.value,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: const Spacing(2).value),
                      Expanded(
                        flex: 1,
                        child: GenCard(
                          radius: BorderRadius.circular(8),
                          withShaddow: false,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: const Spacing(1).value,
                              top: const Spacing(1).value,
                              right: const Spacing(1).value,
                              bottom: const Spacing(2).value,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 139,
                                  color: const Color(0xFFF5F5F5),
                                ),
                                SizedBox(height: const Spacing(1).value),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Title',
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
                                        fontWeight: AppFontWeight.medium.value,
                                      ),
                                    ),
                                    Icon(
                                      CoreIcons.heartOutline,
                                      color: AppColorsBase.neutrla7,
                                    ),
                                  ],
                                ),
                                SizedBox(height: const Spacing(1).value),
                                Text(
                                  'Lorem ipsum dolor sit amet',
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    fontWeight: AppFontWeight.light.value,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ), */
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TagsWidget extends StatelessWidget {
  final List<dynamic> tags;

  const TagsWidget({
    super.key,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: tags.length,
        itemBuilder: (_, index) {
          return Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: const Spacing(0.5).value,
                  horizontal: const Spacing(1).value,
                ),
                decoration: BoxDecoration(
                  // TODO: essa cor não está no theme
                  color: const Color(0xFFE1F3FF),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    tags[index]['name'],
                    style: context.textTheme.bodySmall!.copyWith(
                      fontFamily: 'Inter',
                      fontWeight: AppFontWeight.regular.value,
                      // TODO: essa cor não está no theme
                      color: const Color(0xFF0B6C97),
                    ),
                  ),
                ),
              ),
              index < (tags.length - 1)
                  ? SizedBox(width: const Spacing(1).value)
                  : SizedBox(width: const Spacing(0).value),
            ],
          );
        },
      ),
    );
  }
}

class OpeningHoursWidget extends StatelessWidget {
  final List<dynamic> hours;

  const OpeningHoursWidget({
    super.key,
    required this.hours,
  });

  String get openingHours =>
      'Seg a Sáb - ${hours[0]['open']} às ${hours[0]['close']}\n'
      'Dom e Feriados - ${hours[6]['open']} às ${hours[6]['close']}';

  @override
  Widget build(BuildContext context) {
    return Text(
      openingHours,
      style: context.textTheme.bodySmall!.copyWith(
        fontWeight: AppFontWeight.light.value,
        color: AppColorsBase.neutrla5,
      ),
    );
  }
}

Widget shareableWidget({
  required StoreEntity store,
  required String address,
  required double height,
  required double width,
  required TextStyle titleStyle,
  required TextStyle bodyStyle,
  required TextStyle contactStyle,
}) {
  return Container(
    height: height,
    color: AppColorsBase.neutrla1,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 174.0,
          child: Container(
            color: const Color(0xFF000000),
            height: 162,
            width: width,
            child: Image.network(
              store.logo,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(const Spacing(3).value),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${store.displayName}${store.storeMall.shortName}',
                style: titleStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: const Spacing(2).value),
              Text(
                store.description,
                style: bodyStyle,
              ),
              SizedBox(height: const Spacing(3).value),
              Semantics(
                child: Container(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: AppColorsBase.neutrla0,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColorsBase.neutrla1,
                      width: AppThemeBase.lineHeightRegular,
                    ),
                    boxShadow: [AppThemeBase.shadowLightmodeLevel0],
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: const Spacing(2).value,
                      vertical: const Spacing(3).value,
                    ),
                    child: SizedBox(
                      width: width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Endereço da loja',
                            style: titleStyle,
                          ),
                          SizedBox(height: const Spacing(2).value),
                          Text(
                            address,
                            style: bodyStyle,
                          ),
                          SizedBox(height: const Spacing(1).value),
                          Text(
                            'Contato',
                            style: titleStyle,
                          ),
                          SizedBox(height: const Spacing(2).value),
                          Text(
                            UtilsFormats.phone(
                              store.callNumber,
                            ),
                            style: contactStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
