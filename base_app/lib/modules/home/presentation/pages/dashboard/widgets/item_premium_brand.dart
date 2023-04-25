import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shop/shop.dart';

class ItemPremiumBrand extends StatelessWidget {
  const ItemPremiumBrand({super.key, required this.brand});

  final StoreBrandEntity brand;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Nav.to.pushNamed(
        StoresRoutes.root,
        arguments: brand.name,
        forRoot: true,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(brand.logo),
            backgroundColor: Colors.transparent,
          ),
          Spacing.xs.vertical,
          Text(
            brand.name,
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall!.copyWith(
              fontWeight: AppFontWeight.light.value,
              color: AppColorsBase.neutrla5,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
