import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:home_budget_app/budget_app.dart';

class TransactionNotifier extends StateNotifier<List<TransactionItem>> {
  TransactionNotifier() : super(_generateDummyData());

  static List<TransactionItem> _generateDummyData() {
    return [
      TransactionItem(
        icon: Icons.local_cafe,
        title: 'Cafe',
        description: 'Billy\'s Bakery',
        address: '75 Franklin St, New York, NY 10013, USA',
        time: '11:42',
        amount: 10.95,
      ),
      TransactionItem(
        icon: Icons.shopping_bag,
        title: 'Shop',
        description: 'MoMA Design Store',
        address: '81 Spring St A, New York, NY 10012, USA',
        time: '13:10',
        amount: 122.00,
      ),
      TransactionItem(
        icon: Icons.pets,
        title: 'Pet beauty salon',
        description: 'Candy\'s',
        address: '200 Lafayette St, New York, NY 10012, USA',
        time: '14:56',
        amount: 52.39,
      ),
      // Add more dummy data as needed
    ];
  }

  void removeItem(int index) {
    state = [
      ...state..removeAt(index),
    ];
  }
}

final transactionProvider =
    StateNotifierProvider<TransactionNotifier, List<TransactionItem>>(
  (ref) => TransactionNotifier(),
);
