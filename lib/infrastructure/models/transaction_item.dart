import 'package:flutter/material.dart';

class TransactionItem {
  final IconData icon;
  final String title;
  final String description;
  final String address;
  final String time;
  final double amount;

  TransactionItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.address,
    required this.time,
    required this.amount,
  });
}
