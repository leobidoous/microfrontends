import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../home/domain/entities/product_entity.dart';
import '../stores/cart_store.dart';

class CartProductsList extends StatelessWidget {
  final store = Modular.get<CartStore>();
  CartProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: store.state.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(12),
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, index) {
        return productListItem(
          context,
          store.state[index],
          isLast: store.state[index] == store.state.last,
        );
      },
    );
  }

  Widget productListItem(BuildContext context, ProductEntity product,
      {isLast = false}) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 12),
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
          child: Container(
            color: Colors.grey.withOpacity(0.025),
            child: Row(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(4),
                  child: Image.network(
                    product.image,
                    height: 75,
                    errorBuilder: (_, __, error) {
                      return const Center(
                        child: Icon(
                          Icons.warning_rounded,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(product.name),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: InkWell(
            onTap: () {
              store.removeProduct(product);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.25),
                    spreadRadius: 2.5,
                    blurRadius: 5,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(4),
              child: const Icon(
                Icons.highlight_remove_rounded,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
