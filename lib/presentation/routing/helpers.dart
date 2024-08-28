import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:home_budget_app/budget_app.dart';
import 'dart:developer' as dev show log;

FutureOr<String?> handleRedirect(
  BuildContext context,
  Ref ref,
  GoRouterState state,
) async {
  try {
    FlutterNativeSplash.remove();

    final currentLocation = state.matchedLocation;
    final isValidPath = Routes.values.any(
      (route) => route.path == currentLocation,
    );

    if (!isValidPath) {
      return Routes.notFound.path;
    }

    if (Routes.unprotectedRoutes.contains(state.matchedLocation)) {
      return null;
    }

    return null;
  } catch (e) {
    dev.log('Error: $e', name: 'Router');

    return null;
  }
}

Future<void> showStyledSnackbar({
  required String message,
  bool positive = true,
}) async {
  final fToast = FToast();
  fToast.init(ctx!);
  Widget toast = RippleToast(message: message, positive: positive);

  fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 3));
}
