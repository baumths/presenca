import 'package:flutter/material.dart';

import '../../shared/shared.dart';

ThemeData createLightThemeData(Color seedColor) {
  return _createThemeDataFromBrightness(
    seedColor: seedColor,
    brightness: Brightness.light,
  );
}

ThemeData createDarkThemeData(Color seedColor) {
  return _createThemeDataFromBrightness(
    seedColor: seedColor,
    brightness: Brightness.dark,
  );
}

ThemeData _createThemeDataFromBrightness({
  required Color seedColor,
  required Brightness brightness,
}) {
  return ThemeData(
    colorSchemeSeed: seedColor,
    brightness: brightness,
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    dialogTheme: const DialogTheme(shape: kDefaultShapeBorder),
    dividerTheme: const DividerThemeData(thickness: 1.0),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: kBottomSheetShapeBorder,
    ),
  );
}
