import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../controllers/brands/fetch_store_brands_controller.dart';
import 'widgets/list_brand_tile.dart';

class BrandsPage extends StatefulWidget {
  const BrandsPage({super.key});

  @override
  State<BrandsPage> createState() => _BrandsPageState();
}

class _BrandsPageState extends State<BrandsPage> {
  final storesBrandsController = DM.i.get<FetchStoreBrandsController>();
  final searchController = TextEditingController();
  final searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    storesBrandsController.fetchStoreBrands(params: <String, dynamic>{});
  }

  @override
  void dispose() {
    storesBrandsController.dispose();
    searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsBase.neutrla0,
      appBar: CustomAppBar(
        onBackTap: Nav.to.pop,
        title: 'Marcas',
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
                        ? const SizedBox()
                        : InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              searchController.clear();
                              setState(() {
                                searchController.text;
                              });
                              storesBrandsController.fetchStoreBrands(
                                params: <String, dynamic>{},
                              );
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
                        storesBrandsController.fetchStoreBrands(
                          params: {
                            'filters': {'name': term},
                          },
                        );
                      } else {
                        storesBrandsController
                            .fetchStoreBrands(params: <String, dynamic>{});
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: const Spacing(3).value),
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
                    storesBrandsController.fetchStoreBrands(
                      params: {
                        'pagination': {'orderBy': 'relevance'},
                      },
                    );
                  } else if (newValue == 'Ordem alfabética') {
                    storesBrandsController.fetchStoreBrands(
                      params: {
                        'pagination': {
                          'orderBy': 'display_name',
                          'sortingOrder': 'ASC'
                        },
                      },
                    );
                  } else {
                    storesBrandsController.fetchStoreBrands(
                      params: <String, dynamic>{},
                    );
                  }
                },
              ),
            ),
            SizedBox(height: const Spacing(3).value),
            Expanded(
              child: ListTileBrands(controller: storesBrandsController),
            ),
          ],
        ),
      ),
    );
  }
}
