import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/product_entity.dart';
import '../stores/home_promotions_store.dart';
import '../stores/home_store.dart';

class HomePromotionList extends StatelessWidget {
  final HomePromotionsStore store = Modular.get<HomeStore>().promotionsStore;
  HomePromotionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      scrollDirection: Axis.horizontal,
      child: TripleBuilder(
        store: store,
        builder: (_, triple) {
          if (triple.isLoading) {
          return const Center(child: DefaultLoadingWidget());
        } else if (triple.error != null) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(triple.error.toString()),
                const SizedBox(height: 12),
                DefaultButtonWidget(
                  text: 'Tentar novamente',
                  onPressed: () {
                    triple.clearError();
                    store.getPromotions();
                  },
                ),
              ],
            ),
          );
        }
          return Row(
            children: store.state
                .map((e) => promotionListItem(e, isLast: e == store.state.last))
                .toList(),
          );
        },
      ),
    );
  }

  Widget promotionListItem(ProductEntity product, {isLast = false}) {
    return Container(
      height: 75,
      width: 100,
      color: Colors.red,
      margin: EdgeInsets.only(right: isLast ? 0 : 12),
    );
  }
}
