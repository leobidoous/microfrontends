import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:wallet/wallet.dart';

class SelectPaymentMethodView extends StatefulWidget {
  const SelectPaymentMethodView({super.key, required this.onSelected});

  final Function(CreditCardEntity) onSelected;

  @override
  State<SelectPaymentMethodView> createState() =>
      _SelectPaymentMethodViewState();
}

class _SelectPaymentMethodViewState extends State<SelectPaymentMethodView> {
  final controller = DM.i.get<SelectPaymentMethodController>();
  final cardsController = DM.i.get<FetchCreditCardsController>();

  @override
  void initState() {
    super.initState();
    cardsController.fetchCreditCards();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: const Spacing(2).value),
          child: Text(
            'Escolha uma forma de pagamento',
            style: context.textTheme.titleMedium,
          ),
        ),
        Spacing.sm.vertical,
        Expanded(
          child: ValueListenableBuilder<List<CreditCardEntity>>(
            valueListenable: cardsController,
            builder: (context, state, child) {
              if (cardsController.isLoading) {
                return const Center(child: CustomLoading());
              } else if (cardsController.hasError) {
                return Center(
                  child: RequestError(
                    maxHeight: const Spacing(15).value.responsiveHeight,
                    padding: const EdgeInsets.all(16),
                    message: cardsController.error.toString(),
                    onPressed: cardsController.fetchCreditCards,
                  ),
                );
              } else if (cardsController.state.isEmpty) {
                return Center(
                  child: ListEmpty(
                    asset: 'assets/images/wallet/transactions.svg',
                    message: 'Nenhum cartão cadastrado',
                    padding: const EdgeInsets.all(16),
                    onPressed: cardsController.fetchCreditCards,
                  ),
                );
              }
              return ListView.separated(
                itemBuilder: (_, index) {
                  return PaymentMethodItem(
                    onSelected: widget.onSelected,
                    card: state[index],
                  );
                },
                padding: EdgeInsets.symmetric(
                  horizontal: const Spacing(2).value,
                ),
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (_, __) => Divider(
                  height: const Spacing(2).value,
                  color: AppColorsBase.neutrla1,
                ),
                itemCount: state.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
