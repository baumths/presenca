import 'package:flutter/rendering.dart' show EdgeInsets, EdgeInsetsGeometry;

abstract class AppPadding {
  static const EdgeInsetsGeometry tile = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  );

  static const EdgeInsetsGeometry horizontalMedium = EdgeInsets.symmetric(
    horizontal: 16,
  );

  static const EdgeInsetsGeometry allSmall = EdgeInsets.all(8);
  static const EdgeInsetsGeometry allMedium = EdgeInsets.all(16);
  static const EdgeInsetsGeometry allLarge = EdgeInsets.all(24);
}
