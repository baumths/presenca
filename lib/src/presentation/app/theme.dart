import 'package:flutter/material.dart';

import '../../shared/shared.dart';

final ThemeData theme = ThemeData(
  colorSchemeSeed: Colors.deepPurple,
  useMaterial3: true,
  visualDensity: VisualDensity.comfortable,
  inputDecorationTheme: const InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
    border: OutlineInputBorder(borderRadius: kDefaultBorderRadius),
  ),
  iconTheme: const IconThemeData(size: 20),
  dialogTheme: const DialogTheme(
    shape: RoundedRectangleBorder(borderRadius: kDefaultBorderRadius),
  ),
);
