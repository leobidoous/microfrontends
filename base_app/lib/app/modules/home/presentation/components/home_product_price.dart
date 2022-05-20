import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/product_entity.dart';

class HomeProductPrice extends StatelessWidget {
  final ProductEntity product;
  final toCurrency = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  ).format;
  HomeProductPrice({Key? key, required this.product}) : super(key: key);

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
        toCurrency(product.price),
        style: priceStyle,
      );
    }
    return RichText(
      text: TextSpan(
        text: toCurrency(product.oldPrice),
        style: Theme.of(context).textTheme.headline6?.copyWith(
              fontSize: 12,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
        children: [
          TextSpan(
            text: ' ${toCurrency(product.price)}',
            style: priceStyle,
          ),
        ],
      ),
    );
  }
}
