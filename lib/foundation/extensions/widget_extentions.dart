import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension WidgetX on Widget {
  Page<void> fadeInTransition(
    state, {
    bool force = false,
  }) {
    if (kIsWeb || defaultTargetPlatform == TargetPlatform.macOS || force) {
      final Duration duration = kThemeAnimationDuration * (force ? 2 : 1);

      return CustomTransitionPage<void>(
        key: state.pageKey,
        child: this,
        transitionDuration: duration,
        reverseTransitionDuration: duration,
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      );
    }

    return MaterialPage<void>(
      key: state.pageKey,
      child: this,
    );
  }
}
