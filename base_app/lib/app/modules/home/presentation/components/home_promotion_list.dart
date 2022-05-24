import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/product_entity.dart';
import '../stores/home_store.dart';
import 'home_product_price.dart';

class HomePromotionList extends StatelessWidget {
  final store = Modular.get<HomeStore>().promotionsStore;
  final homeStore = Modular.get<HomeStore>();
  HomePromotionList({Key? key}) : super(key: key);

  void addProductToCart(BuildContext context, ProductEntity product) {
    homeStore.addProductToCart(product: product).then((value) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      value.fold(
        (l) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              padding: EdgeInsets.zero,
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              content: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Erro ao adicionar produto ao carrinho: ${l.toString()}',
                ),
              ),
            ),
          );
        },
        (r) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              padding: EdgeInsets.zero,
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              content: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Produto adicionado ao carrinho com sucesso',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder(
      store: store,
      onError: (_, error) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * .3,
          ),
          child: RequestErrorWidget(
            message: error.toString(),
            onPressed: store.getPromotions,
          ),
        );
      },
      onLoading: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(
              height: 100,
              child: Center(child: DefaultLoadingWidget()),
            ),
          ],
        );
      },
      onState: (_, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: const EdgeInsets.all(12),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: store.state
                .map(
                  (e) => promotionListItem(
                    _,
                    e,
                    isLast: e == store.state.last,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  Widget promotionListItem(BuildContext context, ProductEntity product,
      {isLast = false}) {
    return InkWell(
      onTap: () {
        addProductToCart(context, product);
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
        margin: EdgeInsets.only(right: isLast ? 0 : 12),
        width: MediaQuery.of(context).size.width * .85,
        child: Container(
          color: Colors.grey.withOpacity(0.025),
          child: Row(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(4),
                child: Image.network(
                  product.image,
                  height: 100,
                  errorBuilder: (_, __, error) {
                    return const Center(
                      child: Icon(Icons.warning_rounded, color: Colors.grey),
                    );
                  },
                ),
              ),
              Flexible(
                child: Padding(
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
