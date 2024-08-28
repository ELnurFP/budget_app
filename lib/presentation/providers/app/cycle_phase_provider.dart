import 'package:flutter/foundation.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_budget_app/budget_app.dart';

final cyclePhaseProvider =
    StateNotifierProvider<CyclePhaseNotifier, CyclePhase>(
  (ref) {
    return CyclePhaseNotifier(
      simpleCacheRepository: ref.watch(simpleCacheRepositoryProvider),
    );
  },
);

class CyclePhaseNotifier extends StateNotifier<CyclePhase> {
  final SimpleCacheRepository simpleCacheRepository;

  CyclePhaseNotifier({
    required this.simpleCacheRepository,
  }) : super(CyclePhase.idle);

  Future<void> checkInitially() async {
    try {
      final bool firstLaunch = simpleCacheRepository.getIsFirstLaunch();

      if (firstLaunch) {
        await simpleCacheRepository.setIsFirstLaunch(false);
        await simpleCacheRepository.deleteAllSecure();
      }

      if (kIsWeb || defaultTargetPlatform == TargetPlatform.macOS) {
        state = CyclePhase.root;
      } else {
        final String? token = await simpleCacheRepository.getToken();
        if (token != null) {
          state = CyclePhase.root;
        } else {
          // Todo: add auth here, I am leaving it like that because We dont have auth yet
          state = CyclePhase.root;
        }
      }
    } catch (e) {
      state = CyclePhase.root;
    } finally {
      FlutterNativeSplash.remove();
    }
  }
}
