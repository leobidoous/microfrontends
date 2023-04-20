import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/store_brand_entity.dart';
import '../../../controllers/brands/fetch_store_brands_controller.dart';
import '../../../routes/stores_routes.dart';
import '../../widgets/item_tile.dart';

class ListTileBrands extends StatefulWidget {
  final FetchStoreBrandsController controller;

  const ListTileBrands({super.key, required this.controller});

  @override
  State<ListTileBrands> createState() => _ListTileBrandsState();
}

class _ListTileBrandsState extends State<ListTileBrands> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<StoreBrandEntity>>(
      valueListenable: widget.controller,
      builder: (_, state, child) {
        if (widget.controller.isLoading) {
          return const Center(child: CustomLoading());
        } else if (widget.controller.hasError) {
          return Center(
            child: RequestError(
              padding: const EdgeInsets.all(16),
              message: widget.controller.error.toString(),
              onPressed: () => widget.controller.fetchStoreBrands(),
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
                  StoresRoutes.root,
                  arguments: state[index].name,
                ),
                child: ItemTile(
                  title: state[index].name,
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
