import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/product_entity.dart';

class HomeProductPrice extends StatelessWidget {
  final ProductEntity product;
  
  const HomeProductPrice({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final priceStyle = Theme.of(context).textTheme.headline6?.copyWith(
          color: Theme.of(context).textTheme.headline6?.color,
          decorationStyle: TextDecorationStyle.dotted,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        );
    if (product.oldPrice == null) {
      return Text(
        Number.toCurrency(product.price),
        style: priceStyle,
      );
    }
    return RichText(
      text: TextSpan(
        text: Number.toCurrency(product.oldPrice),
        style: Theme.of(context).textTheme.headline6?.copyWith(
              fontSize: 12,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
        children: [
          TextSpan(
            text: ' ${Number.toCurrency(product.price)}',
            style: priceStyle,
          ),
        ],
      ),
    );
  }
}
