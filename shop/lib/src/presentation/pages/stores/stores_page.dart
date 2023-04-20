import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../controllers/stores/fetch_stores_controller.dart';
import 'widgets/list_tile_stores.dart';

class StoresPage extends StatefulWidget {
  final String brand;
  const StoresPage({super.key, required this.brand});

  @override
  State<StoresPage> createState() => _StoresPageState();
}

class _StoresPageState extends State<StoresPage> {
  final storesController = DM.i.get<FetchStoresController>();
  final searchController = TextEditingController();
  final searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    storesController.fetchStores(
      params: <String, dynamic>{
        'filters': {'brand': widget.brand}
      },
    );
    storesController.setCurrentDay();
    searchController.setText(widget.brand);
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
      backgroundColor: AppColorsBase.neutrla0,
      appBar: CustomAppBar(
        onBackTap: Nav.to.pop,
        title: 'Lojas',
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
                      CoreIcons.search,
                      color: AppColorsBase.neutrla3,
                      size: 20.0,
                    ),
                    suffixIcon: searchController.text == ''
                        ? SizedBox(width: const Spacing(0).value)
                        : InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
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
              ],
            ),
            SizedBox(height: const Spacing(2).value),
            Expanded(
              child: CustomRefreshIndicator(
                onRefresh: () async {
                  storesController.fetchStores(params: <String, dynamic>{});
                },
                child: Container(
                  color: AppColorsBase.neutrla0,
                  child: SafeArea(
                    child: ListTileStores(controller: storesController),
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
