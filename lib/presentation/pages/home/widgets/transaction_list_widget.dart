import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_budget_app/budget_app.dart';

class TransactionList extends ConsumerStatefulWidget {
  const TransactionList({super.key});

  @override
  ConsumerState<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends ConsumerState<TransactionList>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final transactions = ref.watch(transactionProvider);

    if (transactions.isEmpty) {
      return Center(
        child: Text(
          'No transactions yet!'.staticallyTyped(),
          style: const TextStyle(
            color: activeRed,
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];

        return TransactionItemWidget(
          transaction: transaction,
          onDelete: () =>
              ref.read(transactionProvider.notifier).removeItem(index),
        );
      },
    );
  }
}
