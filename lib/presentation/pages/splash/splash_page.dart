import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_budget_app/budget_app.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cyclePhaseProvider.notifier).checkInitially();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      cyclePhaseProvider,
      (_, state) {
        if (state == CyclePhase.root) {
          context.goNamed(Routes.root.name);
        } else if (state == CyclePhase.auth) {
          // gp to auth
        }
      },
    );

    return const Scaffold(
      backgroundColor: Colors.white,
    );
  }
}
