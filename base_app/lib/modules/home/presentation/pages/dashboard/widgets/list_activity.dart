import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:wallet/wallet.dart';

class ListActivity extends StatelessWidget {
  const ListActivity({super.key, required this.controller});

  final FetchTransactionsController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<TransactionEntity>>(
      valueListenable: controller,
      builder: (_, state, child) {
        if (controller.isLoading) {
          return const Center(child: CustomLoading());
        } else if (controller.hasError) {
          return RequestError(
            message: controller.error.toString(),
            onPressed: controller.fetchTransactions,
          );
        } else if (state.isEmpty) {
          return const ListEmpty(
            asset: 'assets/images/wallet/transactions.svg',
            message: 'Você ainda não \npossui atividades',
          );
        }
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: state.length,
          separatorBuilder: (_, __) => Spacing.sm.vertical,
          itemBuilder: (context, index) {
            return TransactionListItem(transaction: state[index]);
          },
        );
      },
    );
  }
}
