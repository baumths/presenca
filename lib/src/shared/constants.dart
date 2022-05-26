import 'package:flutter/material.dart';

const double kDefaultButtonHeight = 48.0;
const double kDefaultCornerRadius = 12.0;

const kDefaultRadius = Radius.circular(kDefaultCornerRadius);

const kDefaultBorderRadius = BorderRadius.all(kDefaultRadius);

const kDefaultShapeBorder = RoundedRectangleBorder(
  borderRadius: kDefaultBorderRadius,
);

const kBottomSheetShapeBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.vertical(top: kDefaultRadius),
);

const VisualDensity kVisualDensity = VisualDensity(
  horizontal: -4,
  vertical: -4,
);
