import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_budget_app/budget_app.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final ctx = navigatorKey.currentContext;

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    navigatorKey: navigatorKey,
    redirect: (BuildContext context, GoRouterState state) {
      return handleRedirect(context, ref, state);
    },
    errorBuilder: (context, state) {
      return const NotFoundPage();
    },
    routes: [
      GoRoute(
        path: Routes.splash.path,
        name: Routes.splash.name,
        pageBuilder: (context, state) {
          return const SplashPage().fadeInTransition(state);
        },
      ),
      GoRoute(
        path: Routes.root.path,
        name: Routes.root.name,
        pageBuilder: (context, state) {
          return const HomePage().fadeInTransition(state, force: true);
        },
      ),
    ],
  ),
);
