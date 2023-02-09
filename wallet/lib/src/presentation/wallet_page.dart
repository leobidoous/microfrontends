import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../domain/entities/transaction_entity.dart';
import 'wallet_controller.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final controller = DM.i.get<WalletController>();

  @override
  void initState() {
    super.initState();
    controller.getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Extrato',
          style: context.textTheme.titleSmall?.copyWith(
            color: context.colorScheme.background,
          ),
        ),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, value, child) {
            if (controller.isLoading) {
              return const Center(child: Loading());
            } else if (controller.hasError) {
              return Center(
                child: RequestError(
                  padding: const EdgeInsets.all(16),
                  message: controller.error.toString(),
                  onPressed: controller.getTransactions,
                ),
              );
            } else if (value.isEmpty) {
              return Center(
                child: ListEmpty(
                  padding: const EdgeInsets.all(16),
                  message: 'Nenhuma transação disponível.',
                  onPressed: controller.getTransactions,
                ),
              );
            }
            return ListView.separated(
              itemCount: value.length,
              separatorBuilder: (_, __) => Spacing.sm.vertical,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return _transactionItem(value[index]);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _transactionItem(TransactionEntity item) {
    return Text(item.type);
  }
}
