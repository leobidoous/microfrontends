import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/store_entity.dart';
import '../../../controllers/stores/fetch_stores_controller.dart';
import '../../../routes/stores_routes.dart';
import '../../widgets/item_tile.dart';

class ListTileShop extends StatefulWidget {
  final FetchStoresController controller;

  const ListTileShop({super.key, required this.controller});

  @override
  State<ListTileShop> createState() => _ListTileShopState();
}

class _ListTileShopState extends State<ListTileShop> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<StoreEntity>>(
      valueListenable: widget.controller,
      builder: (_, state, child) {
        if (widget.controller.isLoading) {
          return const Center(child: CustomLoading());
        } else if (widget.controller.hasError) {
          return Center(
            child: RequestError(
              padding: const EdgeInsets.all(16),
              message: widget.controller.error.toString(),
              onPressed: () =>
                  widget.controller.fetchStores(params: <String, dynamic>{}),
            ),
          );
        } else if (state.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nenhum resultado encontrado',
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: AppFontWeight.bold.value,
                  ),
                ),
                SizedBox(height: const Spacing(3).value),
                Text(
                  'Tente fazer uma nova pesquisa usando outros termos ou '
                  'removendo os filtros de busca.',
                  style: context.textTheme.bodySmall!.copyWith(
                    fontWeight: AppFontWeight.light.value,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        }
        return Container(
          color: context.colorScheme.background,
          child: ListView.separated(
            itemCount: state.length,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            separatorBuilder: (_, __) => Spacing.sm.vertical,
            itemBuilder: (_, index) {
              return InkWell(
                onTap: () => Nav.to.pushNamed(
                  StoresRoutes.detailsStore,
                  arguments: state[index],
                ),
                child: ItemTile(
                  title: '${state[index].displayName}'
                      '${state[index].storeMall.shortName}',
                  brand: state[index].logo,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
