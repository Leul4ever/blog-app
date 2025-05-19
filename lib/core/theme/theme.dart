import 'package:flutter/material.dart';
import 'package:flutter_bloc_app/core/theme/app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.backgroundColor]) =>
      const OutlineInputBorder(
        borderSide: BorderSide(color: AppPallete.borderColor),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppPallete.gradient1,
      selectionColor: AppPallete.gradient1,
      selectionHandleColor: AppPallete.gradient1,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
    ),
  );
}
