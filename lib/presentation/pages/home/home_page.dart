import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_budget_app/budget_app.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          const ChartWidget(),
          32.gap,
          const Expanded(child: TransactionList()),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    final toDay = DateTime.now();
    final day = DateFormat('dd').format(toDay);
    final month = DateFormat('MMM').format(toDay).toUpperCase();

    return AppBar(
      leading: Padding(
        padding:
            const EdgeInsets.only(left: 8.0), // Add padding to align properly
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              month,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      toolbarHeight: 80,
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: SvgPicture.asset(
            'assets/vectors/menu-vertical-svgrepo-com.svg',
            width: 30,
            height: 30,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
      title: const HomeProfileCartWidget(),
      backgroundColor:
          Colors.transparent, // Make AppBar background transparent if needed
      elevation: 0, // Remove shadow if not needed
    );
  }
}
