import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/transaction_entity.dart';
import '../../controllers/credit_card/change_favorite_card_controller.dart';
import '../../controllers/credit_card/fetch_credit_cards_controller.dart';
import '../../controllers/credit_card/remove_credit_card_controller.dart';
import '../../controllers/wallet/transactions_controller.dart';
import 'widgets/credit_cards_list.dart';
import 'widgets/transaction_list_item.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final session = DM.i.get<SessionEntity>();
  final cardsController = DM.i.get<FetchCreditCardsController>();
  final removeCardController = DM.i.get<RemoveCreditCardController>();
  final transactionsController = DM.i.get<FetchTransactionsController>();
  final favoriteCardController = DM.i.get<ChangeFavoriteCardController>();
  late final PagedListController<TransactionEntity, Exception> listController;

  @override
  void initState() {
    super.initState();
    cardsController.fetchCreditCards();

    listController = PagedListController(firstPageKey: 1);
    listController.setListener(({required int pageKey}) async {
      transactionsController.pagination.pageNumber = pageKey;
      await transactionsController.fetchTransactions(
        pagination: transactionsController.pagination,
      );
      if (transactionsController.hasError) {
        return Left(transactionsController.error!);
      }
      return Right(transactionsController.state);
    });
  }

  void onRemoveCard(cardId) async {
    await removeCardController.removeCreditCardById(cardId).then((value) async {
      if (!removeCardController.hasError) {
        cardsController.fetchCreditCards();
        Nav.to.pop();
        return;
      }
      Nav.to.pop();
      await GenDialog.show(
        context,
        GenAlert.deleteCardError(context),
        showClose: true,
      );
    });
  }

  void onChangeFavorite(cardId, isFavorite) async {
    await favoriteCardController
        .updateFavoriteCreditCard(cardId, isFavorite)
        .then((value) {
      if (!favoriteCardController.hasError) {
        cardsController.fetchCreditCards();
        return;
      }
      GenDialog.show(
        context,
        GenAlert.serverError(context),
        showClose: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenAppBar(
        title: 'Carteira',
        automaticallyImplyLeading: Nav.to.canPop(),
        actions: [
          AppBarButton(
            child: Icon(
              GenIcons.messageCircle,
              color: context.colorScheme.onBackground,
            ),
            onTap: () => DM.i.get<ZendeskController>().openChat(),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: GenRefreshIndicator(
        onRefresh: () async {
          cardsController.fetchCreditCards();
          listController.refresh();
        },
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constrains) {
              return GenScrollContent(
                child: SizedBox(
                  height: constrains.maxHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(const Spacing(2).value),
                        child: Text(
                          'Cartões Cadastrados',
                          style: context.textTheme.bodyLarge,
                        ),
                      ),
                      SizedBox(
                        height: const Spacing(15).value.responsiveHeight,
                        child: CreditCardsList(
                          favoriteCardController: favoriteCardController,
                          cardController: cardsController,
                          onChangeFavorite: onChangeFavorite,
                          removeCardController: removeCardController,
                          onRemoveCard: onRemoveCard,
                          emailVerified:
                              session.customer.emailVerifiedAt.isNotEmpty,
                        ),
                      ),
                      Spacing.sm.vertical,
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: const Spacing(2).value,
                        ),
                        child: Text(
                          'Transações',
                          style: context.textTheme.bodyLarge,
                        ),
                      ),
                      Spacing.sm.vertical,
                      Expanded(child: _transactionsList),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget get _transactionsList {
    return PagedListView<TransactionEntity, Exception>(
      listController: listController,
      padding: const EdgeInsets.all(16),
      safeAreaLastItem: false,
      separatorBuilder: (_) => Spacing.sm.vertical,
      noItemsFoundIndicatorBuilder: (_, onPressed) {
        return ListEmpty(
          padding: EdgeInsets.all(const Spacing(2).value),
          asset: 'assets/images/wallet/transactions.svg',
          message: 'Você ainda não \nrealizou transações',
        );
      },
      itemBuilder: (_, item, index) {
        return TransactionListItem(transaction: item);
      },
    );
  }
}
