import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/credit_card_entity.dart';
import '../../controllers/credit_card/fetch_credit_cards_controller.dart';
import '../../controllers/credit_card/remove_credit_card_controller.dart';
import '../../wallet_routes.dart';
import 'widgets/payment_method_item.dart';

class SelectPaymentMethodPage extends StatefulWidget {
  const SelectPaymentMethodPage({super.key, required this.onSelected});
  final Function(CreditCardEntity) onSelected;

  @override
  State<SelectPaymentMethodPage> createState() =>
      _SelectPaymentMethodPageState();
}

class _SelectPaymentMethodPageState extends State<SelectPaymentMethodPage> {
  final cardsController = DM.i.get<FetchCreditCardsController>();
  final removeCardController = DM.i.get<RemoveCreditCardController>();

  @override
  void initState() {
    super.initState();
    cardsController.fetchCreditCards();
  }

  void onRemoveCard(String cardId) async {
    await removeCardController.removeCreditCardById(cardId).then((value) async {
      if (!removeCardController.hasError) {
        cardsController.fetchCreditCards();
        Nav.to.pop();
        return;
      }
      Nav.to.pop();
      await CustomDialog.show(
        context,
        CustomAlert.deleteCardError(context),
        showClose: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Pagamento',
        actions: [
          AppBarButton(
            child: Icon(
              CoreIcons.contactUs,
              color: context.colorScheme.onBackground,
            ),
            onTap: () => DM.i.get<ZendeskController>().openChat(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(const Spacing(2).value),
              child: Text(
                'Escolha uma forma de pagamento',
                style: context.textTheme.titleMedium,
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<List<CreditCardEntity>>(
                valueListenable: cardsController,
                builder: (context, value, child) {
                  if (cardsController.isLoading) {
                    return const Center(child: CustomLoading());
                  } else if (cardsController.hasError) {
                    return Center(
                      child: RequestError(
                        padding: EdgeInsets.all(const Spacing(2).value),
                        message: cardsController.error.toString(),
                        onPressed: cardsController.fetchCreditCards,
                      ),
                    );
                  } else if (cardsController.state.isEmpty) {
                    return Center(
                      child: ListEmpty(
                        asset: 'assets/images/wallet/transactions.svg',
                        message: 'Nenhum cartão cadastrado',
                        padding: EdgeInsets.all(const Spacing(2).value),
                        onPressed: cardsController.fetchCreditCards,
                      ),
                    );
                  }
                  return CustomRefreshIndicator(
                    onRefresh: () async {
                      cardsController.fetchCreditCards();
                    },
                    child: ListView.separated(
                      separatorBuilder: (_, __) => Spacing.sm.vertical,
                      itemCount: cardsController.state.length,
                      padding: EdgeInsets.all(const Spacing(2).value),
                      itemBuilder: (_, index) {
                        // IMPORTANT: User can't have more than 2 credit cards
                        if (cardsController.state.length < 2) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              PaymentMethodItem(
                                onRemoveCard: onRemoveCard,
                                onSelected: widget.onSelected,
                                card: cardsController.state[index],
                                removeCardController: removeCardController,
                              ),
                              if (cardsController.state.last ==
                                  cardsController.state[index]) ...[
                                Spacing.sm.vertical,
                                _addNewCreditCard,
                              ]
                            ],
                          );
                        }

                        return PaymentMethodItem(
                          onRemoveCard: onRemoveCard,
                          onSelected: widget.onSelected,
                          card: cardsController.state[index],
                          removeCardController: removeCardController,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _addNewCreditCard {
    return CustomCard(
      shaddow: const [],
      border: context.theme.borderZero,
      padding: EdgeInsets.all(const Spacing(2).value),
      onTap: () {
        Nav.to
            .pushNamed(
          WalletRoutes.addCreditCard.prevPath(),
          forRoot: true,
        )
            .then((value) {
          if (value is CreditCardEntity) {
            cardsController.addNewCreditCard(value);
          }
        });
      },
      child: Row(
        children: [
          Icon(
            Icons.add_rounded,
            color: context.colorScheme.primary,
            size: const Spacing(3).value,
          ),
          Spacing.sm.horizontal,
          Expanded(
            child: Text(
              'Registrar novo cartão',
              style: context.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
