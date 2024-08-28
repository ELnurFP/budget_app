import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

extension NumX on num {
  Widget get gap => Gap(toDouble());
}
