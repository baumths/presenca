import 'package:flutter/rendering.dart' show EdgeInsets;

abstract class AppPadding {
  static const EdgeInsets tile = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  );

  static const EdgeInsets horizontalMedium = EdgeInsets.symmetric(
    horizontal: 16,
  );

  static const EdgeInsets horizontalSmall = EdgeInsets.symmetric(
    horizontal: 8,
  );

  static const EdgeInsets allSmall = EdgeInsets.all(8);
  static const EdgeInsets allMedium = EdgeInsets.all(16);
  static const EdgeInsets allLarge = EdgeInsets.all(24);
}
