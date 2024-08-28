import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_budget_app/budget_app.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      title: AppValues.appName,
      debugShowCheckedModeBanner: false,
      theme: Themes.dark,
      builder: FToastBuilder(),
    );
  }
}
