import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'components/cart_products_list.dart';
import 'stores/cart_store.dart';

class CartPage extends StatefulWidget {
  final PageController pageController;
  const CartPage({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final store = Modular.get<CartStore>();

  @override
  void initState() {
    super.initState();
    store.getCartProducts();
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder(
      store: store,
      builder: (_, triple) {
        if (triple.isLoading) {
          return const Center(child: DefaultLoadingWidget());
        } else if (triple.error != null) {
          return Center(
            child: RequestErrorWidget(
              message: triple.error.toString(),
              onPressed: () {
                triple.clearError();
                store.getCartProducts();
              },
            ),
          );
        }
        if (store.state.isEmpty) return loadingCart;
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
              Expanded(child: CartProductsList()),
              const Divider(height: 0),
              const SizedBox(height: 8),
              orderDetails,
              Padding(
                padding: const EdgeInsets.all(12),
                child: DefaultButtonWidget(
                  text: 'Finalizar pedido',
                  onPressed: () {
                    DefaultDialog().show(context, creatingOrder);
                    store.cartCreateOrderStore.createOrder().then((value) {
                      if (store.cartCreateOrderStore.state.items.isEmpty) {
                        store.cleanCart();
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget get creatingOrder {
    return ScopedBuilder(
      store: store.cartCreateOrderStore,
      onLoading: (_) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Criando seu pedido',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              const Divider(),
              const DefaultLoadingWidget(),
            ],
          ),
        );
      },
      onError: (_, error) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Erro ao criar seu pedido',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              const Divider(),
              RequestErrorWidget(message: error.toString()),
              const SizedBox(height: 12),
              DefaultButtonWidget(text: 'Fechar', onPressed: Modular.to.pop),
            ],
          ),
        );
      },
      onState: (_, state) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Pedido criado com sucesso!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              const Padding(
                padding: EdgeInsets.all(12),
                child: Icon(
                  Icons.done_rounded,
                  color: Colors.green,
                  size: 120,
                ),
              ),
              DefaultButtonWidget(text: 'Fechar', onPressed: Modular.to.pop),
            ],
          ),
        );
      },
    );
  }

  Widget get loadingCart {
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
              Text(Number.toCurrency(0.00), style: fieldStyle),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal:', style: titleStyle),
              Text(Number.toCurrency(store.getCartSubtotal), style: fieldStyle),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Descontos:', style: titleStyle),
              Text(Number.toCurrency(store.getCartDiscount), style: fieldStyle),
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
                Number.toCurrency(store.getCartTotalPrice),
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
