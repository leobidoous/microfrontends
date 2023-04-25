import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shop/shop.dart';

import 'item_premium_brand.dart';

class ListPremiumBrands extends StatelessWidget {
  final FetchStoreBrandsController controller;

  const ListPremiumBrands({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<StoreBrandEntity>>(
      valueListenable: controller,
      builder: (_, state, child) {
        if (controller.isLoading) {
          return const CustomLoading();
        } else if (controller.hasError) {
          return RequestError(message: controller.error.toString());
        } else if (state.isEmpty) {
          return Text(
            'Nenhuma marca encontrada',
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium,
          );
        }
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 1 / 1.25,
          ),
          itemCount: state.length,
          itemBuilder: (context, index) {
            return index < 9
                ? ItemPremiumBrand(brand: state[index])
                : InkWell(
                    onTap: () => Nav.to.pushNamed(StoresRoutes.root),
                    child: Column(
                      children: [
                        Spacing.sm.vertical,
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: context.colorScheme.primary,
                          child: Icon(
                            CoreIcons.rightOutline,
                            color: context.colorScheme.background,
                            size: AppFontSize.titleMedium.value,
                          ),
                        ),
                        Spacing.xs.vertical,
                        Text(
                          'Ver mais',
                          textAlign: TextAlign.center,
                          style: context.textTheme.bodySmall!.copyWith(
                            fontWeight: AppFontWeight.medium.value,
                            color: context.colorScheme.primary,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  );
          },
        );
      },
    );
  }
}
