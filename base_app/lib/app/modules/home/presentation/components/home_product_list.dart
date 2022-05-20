import 'dart:ui';

import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app_routes.dart';
import '../../domain/entities/product_entity.dart';
import '../stores/home_products_store.dart';
import '../stores/home_store.dart';
import 'home_product_price.dart';

class HomeProductList extends StatelessWidget {
  final HomeProductsStore store = Modular.get<HomeStore>().productsStore;

  HomeProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder(
      store: store,
      onError: (_, error) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(error.toString()),
              const SizedBox(height: 12),
              DefaultButtonWidget(
                text: 'Tentar novamente',
                onPressed: store.getProducts,
              ),
            ],
          ),
        );
      },
      onLoading: (_) {
        return const Center(child: DefaultLoadingWidget());
      },
      onState: (_, state) {
        return RefreshIndicator(
          onRefresh: () async {
            store.getProducts();
          },
          child: GridView.builder(
            itemCount: store.state.length,
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 250,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (_, index) {
              return productGridItem(
                context,
                store.state[index],
                isLast: store.state[index] == store.state.last,
              );
            },
          ),
        );
      },
    );
  }

  Widget productGridItem(BuildContext context, ProductEntity product,
      {isLast = false}) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed(
          '${AppRoutes.productDetails.replaceAll('/', '')}/',
          arguments: product,
        );
      },
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey, width: 0.1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 2.5,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Image.network(
                      product.image,
                      errorBuilder: (_, __, error) {
                        return const Center(
                          child:
                              Icon(Icons.warning_rounded, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                  if (product.discount != null)
                    productDiscount(context, product),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Colors.black.withOpacity(0.75),
                          fontSize: 14,
                        ),
                  ),
                  const SizedBox(height: 4),
                  HomeProductPrice(product: product),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey, width: 0.5),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            '${product.colors} cores',
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: product.freeShipping
                              ? Text(
                                  'Frete Gratis',
                                  textAlign: TextAlign.end,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                        fontSize: 12,
                                        color: Colors.blue,
                                      ),
                                )
                              : const SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget productDiscount(BuildContext context, ProductEntity product) {
    return Positioned(
      right: 0,
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.01),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
                width: 0.5,
              ),
              color: Colors.white,
            ),
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              '${product.discount}% OFF',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontSize: 11,
                    color: Colors.red,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
