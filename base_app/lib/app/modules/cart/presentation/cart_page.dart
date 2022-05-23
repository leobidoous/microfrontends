import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'components/cart_products_list.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    if (1 == int.tryParse('x')) {
      return Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.add_shopping_cart_rounded,
                color: Colors.grey,
                size: 100,
              ),
              Text(
                'Ops, parece que voce ainda não '
                'adicionou produtos ao seu carrinho.',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      extendBody: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
            child: Text(
              'Revise os detalhes do seu pedido',
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Divider(height: 0),
          const Expanded(child: CartProductsList()),
          orderDetails,
          Padding(
            padding: const EdgeInsets.all(12),
            child: DefaultButtonWidget(
              text: 'Confirmar pedido',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget get orderDetails {
    final titleStyle = Theme.of(context).textTheme.headline6?.copyWith(
          color: Colors.grey,
        );
    final fieldStyle = Theme.of(context).textTheme.headline6?.copyWith(
          color: Colors.black,
          fontSize: 13,
        );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Frete:', style: titleStyle),
              Text(Number.toCurrency(100.00), style: fieldStyle),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal:', style: titleStyle),
              Text(Number.toCurrency(329.00), style: fieldStyle),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Descontos:', style: titleStyle),
              Text(Number.toCurrency('0.00'), style: fieldStyle),
            ],
          ),
          const Divider(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: titleStyle?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                Number.toCurrency(429.00),
                style: fieldStyle?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
