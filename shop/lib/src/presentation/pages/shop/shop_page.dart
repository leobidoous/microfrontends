import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../controllers/stores/fetch_stores_controller.dart';
import '../../routes/shop_routes.dart';
import 'widgets/list_shop_tile.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final storesController = DM.i.get<FetchStoresController>();
  final searchController = TextEditingController();
  final searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    storesController.fetchStores(params: <String, dynamic>{});
  }

  @override
  void dispose() {
    storesController.dispose();
    searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onBackTap: Nav.to.pop,
        title: 'Compras',
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(const Spacing(3).value),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomInputField(
                    controller: searchController,
                    padding: EdgeInsets.zero,
                    focusNode: searchFocus,
                    autofocus: false,
                    hintText: 'Pesquisar',
                    prefixIcon: Icon(
                      CoreIcons.searchOutline,
                      color: AppColorsBase.neutrla3,
                      size: 20.0,
                    ),
                    suffixIcon: searchController.text == ''
                        ? SizedBox(width: const Spacing(0).value)
                        : InkWell(
                            onTap: () {
                              searchController.clear();
                              setState(() {
                                searchController.text;
                              });
                              storesController
                                  .fetchStores(params: <String, dynamic>{});
                            },
                            child: Icon(
                              CoreIcons.block,
                              color: AppColorsBase.neutrla3,
                              size: 20.0,
                            ),
                          ),
                    onChanged: (term) {
                      setState(() {
                        searchController.text;
                      });
                      if (term != '') {
                        storesController.fetchStores(
                          params: {
                            'filters': {'searchTerm': term},
                          },
                        );
                      } else {
                        storesController
                            .fetchStores(params: <String, dynamic>{});
                      }
                    },
                  ),
                ),
                //TODO: Funcionalidade ainda em desenvolvimento
                /* SizedBox(width: const Spacing(2).value),
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
                    GenIcons.scan,
                    color: AppColorsBase.textButtonColor,
                  ),
                ), */
              ],
            ),
            SizedBox(height: const Spacing(3).value),
            //TODO: Serviço ainda não está pronto
            /* TextLink(
              text: 'Ver lojas próximas',
              onTap: () {
                GenDialog.show(
                  context,
                  GenAlert.noImplementation(
                    context,
                  ),
                  showClose: true,
                );
              },
            ),
            SizedBox(height: const Spacing(3).value), */
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    buttonStyleData: ButtonStyleData(
                      width: 110,
                      height: 20,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: AppColorsBase.neutrla0,
                      ),
                      elevation: 0,
                    ),
                    hint: Text(
                      'Ordenar por',
                      style: context.textTheme.bodySmall!.copyWith(
                        fontFamily: 'Poppins',
                        fontWeight: AppFontWeight.regular.value,
                        color: AppColorsBase.neutrla5,
                      ),
                    ),
                    iconStyleData: IconStyleData(
                      icon: const Icon(
                        CoreIcons.chevronDown,
                      ),
                      iconSize: 14,
                      iconEnabledColor: AppColorsBase.neutrla5,
                      iconDisabledColor: Colors.grey,
                      openMenuIcon: const Icon(
                        CoreIcons.chevronUp,
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: context.screenWidth * 0.5,
                      width: context.screenWidth * 0.5,
                      padding: null,
                      decoration: BoxDecoration(
                        color: AppColorsBase.neutrla0,
                      ),
                      elevation: 0,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 30,
                      padding: EdgeInsets.zero,
                    ),
                    items: <String>['Mais relevantes', 'Ordem alfabética']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: context.textTheme.bodySmall!.copyWith(
                            fontWeight: AppFontWeight.regular.value,
                            color: AppColorsBase.neutrla5,
                          ),
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      if (newValue == 'Mais relevantes') {
                        storesController.fetchStores(
                          params: {
                            'pagination': {'orderBy': 'relevance'},
                          },
                        );
                      } else if (newValue == 'Ordem alfabética') {
                        storesController.fetchStores(
                          params: {
                            'pagination': {
                              'orderBy': 'display_name',
                              'sortingOrder': 'ASC'
                            },
                          },
                        );
                      } else {
                        storesController
                            .fetchStores(params: <String, dynamic>{});
                      }
                    },
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Nav.to.pushNamed(ShopRoutes.filterShop).then((params) {
                        if (params is Map<String, dynamic>) {
                          storesController.fetchStores(
                            params: {
                              'filters': params['filters'],
                              'pagination': params['pagination'],
                            },
                          );
                        }
                      });
                    },
                    child: SizedBox(
                      width: 75.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Filtro',
                            style: context.textTheme.bodySmall!.copyWith(
                              fontWeight: AppFontWeight.regular.value,
                              color: AppColorsBase.neutrla5,
                            ),
                          ),
                          SizedBox(width: const Spacing(1).value),
                          Icon(
                            CoreIcons.filter,
                            color: AppColorsBase.neutrla5,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: const Spacing(3).value),
            Text(
              'Lojas',
              style: context.textTheme.bodyLarge!.copyWith(
                fontFamily: 'Inter',
                fontWeight: AppFontWeight.medium.value,
              ),
            ),
            SizedBox(height: const Spacing(3).value),
            Expanded(
              child: CustomRefreshIndicator(
                onRefresh: () async {
                  storesController.fetchStores(params: <String, dynamic>{});
                },
                child: Container(
                  color: AppColorsBase.neutrla0,
                  child: SafeArea(
                    child: ListTileShop(controller: storesController),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
