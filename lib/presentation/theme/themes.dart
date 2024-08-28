import 'package:flutter/material.dart';
import 'package:home_budget_app/budget_app.dart';

class Themes {
  static ThemeData get dark {
    final theme = ThemeData(
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        surfaceTintColor: background,
      ),
      colorSchemeSeed: primary,
      dialogTheme: const DialogTheme(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
    );

    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        centerTitle: false,
        titleTextStyle: const TextStyle(
          fontFamily: AppValues.appBarFontFamily,
          color: primary,
          fontWeight: FontWeight.w700,
          fontSize: 18.0,
          height: 28 / 18.0,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: borderColor,
        space: 0.0,
        thickness: 1.0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 14.0,
        ),
        hintStyle: const TextStyle(color: grey),
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: primary,
            width: 2.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red.shade700,
            width: 2.0,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red.shade500,
            width: 2.0,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
      textTheme: theme.textTheme.apply(
        fontFamily: AppValues.appFontFamily,
        displayColor: secondary,
        bodyColor: secondary,
      ),
    );
  }
}
