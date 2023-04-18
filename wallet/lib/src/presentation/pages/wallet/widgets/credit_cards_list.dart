import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/credit_card_entity.dart';
import '../../../../domain/enums/credit_card_type.dart';
import '../../../controllers/credit_card/change_favorite_card_controller.dart';
import '../../../controllers/credit_card/fetch_credit_cards_controller.dart';
import '../../../controllers/credit_card/remove_credit_card_controller.dart';
import '../../../wallet_routes.dart';
import '../../widgets/delete_credit_card.dart';

class CreditCardsList extends StatefulWidget {
  final FetchCreditCardsController cardController;
  final RemoveCreditCardController removeCardController;
  final ChangeFavoriteCardController favoriteCardController;
  final Function(String, bool) onChangeFavorite;
  final Function(String) onRemoveCard;
  final bool emailVerified;

  const CreditCardsList({
    super.key,
    required this.cardController,
    required this.favoriteCardController,
    required this.onChangeFavorite,
    required this.removeCardController,
    required this.onRemoveCard,
    required this.emailVerified,
  });

  @override
  State<CreditCardsList> createState() => _CreditCardsListState();
}

class _CreditCardsListState extends State<CreditCardsList> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<CreditCardEntity>>(
      valueListenable: widget.cardController,
      builder: (_, state, child) {
        if (widget.cardController.isLoading) {
          return Row(
            children: [
              Expanded(
                child: GenScrollContent(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                    horizontal: const Spacing(2).value,
                  ),
                  child: Row(
                    children: List.generate(
                      5,
                      (index) => _creditCardListItemShimmer(isLast: index == 4),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (widget.cardController.hasError) {
          return Center(
            child: RequestError(
              maxHeight: const Spacing(15).value.responsiveHeight,
              padding: const EdgeInsets.all(16),
              message: widget.cardController.error.toString(),
              onPressed: widget.cardController.fetchCreditCards,
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {},
          child: Row(
            children: [
              Expanded(
                child: GenScrollContent(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                    horizontal: const Spacing(2).value,
                  ),
                  child: Row(
                    children: [
                      // IMPORTANT: User can't have more than 2 credit cards
                      if (state.length < 2) _addCreditCard,
                      ...state
                          .map(
                            (e) => _cardListItem(e, isLast: e == state.last),
                          )
                          .toList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _creditCardContainer({
    required Widget child,
    VoidCallback? onTap,
    bool isLast = false,
  }) {
    return Padding(
      padding: isLast
          ? EdgeInsets.zero
          : EdgeInsets.only(right: const Spacing(2).value),
      child: GenCard(
        border: Border.all(
          color: AppColorsBase.neutrla2,
          width: 1,
        ),
        radius: context.theme.borderRadiusXSM,
        onTap: onTap,
        child: SizedBox(
          height: const Spacing(15).value.responsiveHeight,
          width: const Spacing(15).value.responsiveWidth,
          child: Padding(
            padding: EdgeInsets.all(const Spacing(1).value),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget get _addCreditCard {
    return _creditCardContainer(
      onTap: () {
        if (widget.emailVerified) {
          Nav.to
              .pushNamed(WalletRoutes.addCreditCard.relativePath, forRoot: true)
              .then((value) {
            if (value is CreditCardEntity) {
              widget.cardController.addNewCreditCard(value);
            }
          });
        } else {
          GenDialog.show(
            context,
            GenAlert.emailVerified(context),
            showClose: true,
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.add_rounded,
            color: context.colorScheme.primary,
          ),
          Spacing.sm.vertical,
          Flexible(
            child: Text(
              'Cadastrar novo cartão',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardListItem(CreditCardEntity card, {isLast = false}) {
    return _creditCardContainer(
      isLast: isLast,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        card.brand.image,
                        height: 12.responsiveHeight,
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                      ),
                      Spacing.xxs.vertical,
                      Flexible(
                        child: Text(
                          'Crédito',
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.labelSmall,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacing.xs.horizontal,
                DeleteCreditCard(
                  card: card,
                  onRemoveCard: widget.onRemoveCard,
                  removeCardController: widget.removeCardController,
                ),
              ],
            ),
          ),
          Spacing.sm.vertical,
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          card.brand.name.capitalize,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.labelSmall,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          '****${card.last4}',
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.labelSmall,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacing.xs.horizontal,
                ValueListenableBuilder(
                  valueListenable: widget.favoriteCardController,
                  builder: (_, state, child) {
                    if (widget.favoriteCardController.isChangingFavorite(
                      card,
                    )) {
                      return GenLoading(
                        height: const Spacing(3).value,
                        width: const Spacing(3).value,
                      );
                    }
                    return InkWell(
                      onTap: () {
                        widget.favoriteCardController.onChangingFavorite(card);
                        widget.onChangeFavorite(card.id, !card.isFavorite);
                      },
                      child: Icon(
                        card.isFavorite
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        color: context.colorScheme.primary,
                        size: const Spacing(3).value,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _creditCardListItemShimmer({bool isLast = false}) {
    return _creditCardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GenShimmer(height: const Spacing(1.5).value),
                      Spacing.xxs.vertical,
                      GenShimmer(
                        height: const Spacing(1.5).value,
                        width: 40.responsiveWidth,
                      ),
                    ],
                  ),
                ),
                Spacing.xs.horizontal,
                Icon(
                  CoreIcons.deleteOutline,
                  color: AppColorsBase.grey7,
                  size: const Spacing(2.5).value,
                ),
              ],
            ),
          ),
          Spacing.sm.vertical,
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: GenShimmer(height: const Spacing(1.5).value),
                      ),
                      Spacing.xxs.vertical,
                      Flexible(
                        child: GenShimmer(
                          height: const Spacing(1.5).value,
                          width: 60.responsiveWidth,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacing.xs.horizontal,
                Icon(
                  Icons.star_outline_rounded,
                  size: const Spacing(3).value,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
