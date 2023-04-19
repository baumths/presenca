import 'package:flutter/material.dart';

import '../../shared/shared.dart';

ThemeData createLightThemeData(Color seedColor) {
  return _createThemeDataFromColorScheme(
    ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    ),
  );
}

ThemeData createDarkThemeData(Color seedColor) {
  return _createThemeDataFromColorScheme(
    ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    ),
  );
}

ThemeData _createThemeDataFromColorScheme(ColorScheme colorScheme) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    dialogTheme: const DialogTheme(shape: kDefaultShapeBorder),
    dividerTheme: const DividerThemeData(thickness: 1.0),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
    ),
  );
}
