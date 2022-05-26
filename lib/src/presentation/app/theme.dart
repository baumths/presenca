import 'package:flutter/material.dart';

import '../../shared/shared.dart';

final ThemeData theme = ThemeData(
  colorScheme: colorScheme,
  useMaterial3: true,
  visualDensity: VisualDensity.comfortable,
  iconTheme: const IconThemeData(size: 20),
  dialogTheme: const DialogTheme(shape: kDefaultShapeBorder),
  bottomAppBarTheme: BottomAppBarTheme(color: colorScheme.surface),
  dividerTheme: DividerThemeData(
    color: colorScheme.outline,
    thickness: 1.0,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    shape: kBottomSheetShapeBorder,
  ),
);

final ColorScheme colorScheme = ColorScheme.fromSeed(
  seedColor: Colors.teal,
  brightness: Brightness.light,
);
