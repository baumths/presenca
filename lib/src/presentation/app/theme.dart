import 'package:flutter/material.dart';

import '../../shared/constants.dart';

final ThemeData theme = ThemeData(
  colorScheme: colorScheme,
  visualDensity: VisualDensity.comfortable,
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: kDefaultBorderRadius,
    ),
  ),
);

final ColorScheme colorScheme = ColorScheme.fromSwatch(
  primarySwatch: Colors.deepPurple,
  primaryColorDark: Colors.deepPurpleAccent,
  accentColor: Colors.orange.shade800,
);
