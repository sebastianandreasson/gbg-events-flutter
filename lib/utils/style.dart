import 'dart:ui';

import 'package:flutter/material.dart';

class Styling {
  /*
    Colors
  */
  static const Color primaryColor = Color.fromRGBO(221, 72, 41, 1);
  static const Color backgroundColor = Color.fromRGBO(248, 241, 224, 1);

  static const Color primaryTextColor = Color.fromRGBO(15, 15, 15, 1);
  static const Color secondaryTextColor = Color.fromRGBO(54, 52, 71, 1);

  static Map<int, Color> swatch = {
    50: primaryColor.withOpacity(.1),
    100: primaryColor.withOpacity(.2),
    200: primaryColor.withOpacity(.3),
    300: primaryColor.withOpacity(.4),
    400: primaryColor.withOpacity(.5),
    500: primaryColor.withOpacity(.6),
    600: primaryColor.withOpacity(.7),
    700: primaryColor.withOpacity(.8),
    800: primaryColor.withOpacity(.9),
    900: primaryColor.withOpacity(1),
  };

  static MaterialColor primarySwatch = MaterialColor(
    primaryColor.value,
    swatch,
  );

  /*
    Styling
  */
  static const TextStyle headingStyle = TextStyle(
    fontFamily: 'Cormorant',
    fontSize: 34,
    fontWeight: FontWeight.w700,
    color: Styling.primaryTextColor,
  );

  /*
    Layout
  */
  static const double defaultSpacing = 8.0;
  static const double largeSpacing = 7 * defaultSpacing;
  static const SizedBox defaultSpacer = SizedBox(height: defaultSpacing);
}
