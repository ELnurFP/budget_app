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
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<TransactionItem> transactions;
  bool _isInitialBuild = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateList());
  }

  @override
  Widget build(BuildContext context) {
    transactions = ref.watch(transactionProvider);

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

    return AnimatedList(
      key: _listKey,
      initialItemCount: _isInitialBuild ? 0 : transactions.length,
      itemBuilder: (context, index, animation) {
        final transaction = transactions[index];
        return _buildTransactionItem(transaction, index, animation);
      },
    );
  }

  Widget _buildTransactionItem(
    TransactionItem transaction,
    int index,
    Animation<double> animation,
  ) {
    return SizeTransition(
      sizeFactor: animation,
      axisAlignment: 0.0,
      child: TransactionItemWidget(
        transaction: transaction,
        onDelete: () => _removeItem(index),
      ),
    );
  }

  void _removeItem(int index) {
    final transaction = transactions[index];
    ref.read(transactionProvider.notifier).removeItem(index);

    // Trigger the animation for the removal
    _listKey.currentState!.removeItem(
      index,
      (context, animation) =>
          _buildTransactionItem(transaction, index, animation),
      duration: const Duration(milliseconds: 300),
    );
  }

  void _animateList() {
    if (_isInitialBuild && transactions.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 100), () {
        for (int i = 0; i < transactions.length; i++) {
          Future.delayed(Duration(milliseconds: i * 200), () {
            _listKey.currentState
                ?.insertItem(i, duration: const Duration(milliseconds: 300));
          });
        }
        _isInitialBuild = false;
      });
    }
  }
}
