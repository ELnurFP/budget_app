import 'package:flutter/material.dart';

const typography = TypographyData(
  sp8: TextStyle(fontSize: 8.0),
  sp10: TextStyle(fontSize: 10.0),
  sp12: TextStyle(fontSize: 12.0),
  sp14: TextStyle(fontSize: 14.0),
  sp16: TextStyle(fontSize: 16.0),
  sp18: TextStyle(fontSize: 18.0),
  sp20: TextStyle(fontSize: 20.0),
  sp22: TextStyle(fontSize: 22.0),
  sp24: TextStyle(fontSize: 24.0),
  sp28: TextStyle(fontSize: 28.0),
  sp32: TextStyle(fontSize: 32.0),
  sp34: TextStyle(fontSize: 34.0),
  sp36: TextStyle(fontSize: 36.0),
  sp38: TextStyle(fontSize: 38.0),
  sp40: TextStyle(fontSize: 40.0),
);

class TypographyData {
  const TypographyData({
    required this.sp8,
    required this.sp10,
    required this.sp12,
    required this.sp14,
    required this.sp16,
    required this.sp18,
    required this.sp20,
    required this.sp22,
    required this.sp24,
    required this.sp28,
    required this.sp32,
    required this.sp34,
    required this.sp36,
    required this.sp38,
    required this.sp40,
  });

  final TextStyle sp8;
  final TextStyle sp10;
  final TextStyle sp12;
  final TextStyle sp14;
  final TextStyle sp16;
  final TextStyle sp18;
  final TextStyle sp20;
  final TextStyle sp22;
  final TextStyle sp24;
  final TextStyle sp28;
  final TextStyle sp32;
  final TextStyle sp34;
  final TextStyle sp36;
  final TextStyle sp38;
  final TextStyle sp40;
}
