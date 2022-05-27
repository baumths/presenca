import 'package:flutter/material.dart';

import '../../shared/shared.dart';

ThemeData createThemeData(Color seedColor) {
  return ThemeData(
    colorSchemeSeed: seedColor,
    useMaterial3: true,
    visualDensity: VisualDensity.comfortable,
    iconTheme: const IconThemeData(size: 20),
    dialogTheme: const DialogTheme(shape: kDefaultShapeBorder),
    dividerTheme: const DividerThemeData(thickness: 1.0),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: kBottomSheetShapeBorder,
    ),
  );
}

ThemeData createDarkThemeData(Color seedColor) {
  return ThemeData(
    colorSchemeSeed: seedColor,
    brightness: Brightness.dark,
    useMaterial3: true,
    visualDensity: VisualDensity.comfortable,
    iconTheme: const IconThemeData(size: 20),
    dialogTheme: const DialogTheme(shape: kDefaultShapeBorder),
    dividerTheme: const DividerThemeData(thickness: 1.0),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: kBottomSheetShapeBorder,
    ),
  );
}
