// import 'package:base_style_sheet/base_style_sheet.dart';
// import 'package:core/core.dart';
// import 'package:flutter/material.dart';

// class ListActivity extends StatelessWidget {
//   final TransactionsController controller;

//   const ListActivity({
//     super.key,
//     required this.controller,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<List<TransactionEntity>>(
//       valueListenable: controller,
//       builder: (_, state, child) {
//         if (controller.isLoading) {
//           return const Center(child: GenLoading());
//         } else if (controller.hasError) {
//           return Center(
//             child: RequestError(
//               message: controller.error.toString(),
//               onPressed: controller.fetchTransactions,
//             ),
//           );
//         } else if (state.isEmpty) {
//           return Center(
//             child: ListEmpty(
//               asset: 'assets/images/wallet/transactions.svg',
//               message: 'Você ainda não possui atividades',
//               onPressed: controller.fetchTransactions,
//             ),
//           );
//         }
//         return ListView.separated(
//           physics: const BouncingScrollPhysics(),
//           shrinkWrap: true,
//           padding: EdgeInsets.zero,
//           itemCount: state.length,
//           separatorBuilder: (_, __) => Spacing.sm.vertical,
//           itemBuilder: (context, index) {
//             return TransactionListItem(transaction: state[index]);
//           },
//         );
//       },
//     );
//   }
// }
