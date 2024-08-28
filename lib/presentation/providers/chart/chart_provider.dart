import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

class ChartData {
  final String hour;
  final double value;

  ChartData(this.hour, this.value);
}

class ChartDataNotifier extends StateNotifier<List<ChartData>> {
  ChartDataNotifier() : super(_generateDummyData());

  static List<ChartData> _generateDummyData() {
    final random = Random();
    return List.generate(24, (index) {
      final randomValue = (random.nextDouble() * 45) + 5;
      final hour = '${index.toString().padLeft(2, '0')}:00';

      final roundedValue = double.parse(randomValue.toStringAsFixed(2));

      return ChartData(hour, roundedValue);
    });
  }
}

final chartDataProvider =
    StateNotifierProvider<ChartDataNotifier, List<ChartData>>(
  (ref) => ChartDataNotifier(),
);
