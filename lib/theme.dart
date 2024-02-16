import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Created with https://m2.material.io/design/color/the-color-system.html#tools-for-picking-colors
const ColorScheme uptimeColor = ColorScheme(
  primary: Color(0xffdddddd),
  onPrimary: Color(0xff222222),
  secondary: Color(0xffdddddd),
  onSecondary: Color(0xff222222),
  surface: Color(0xffdddddd),
  onSurface: Color(0xff222222),
  background: Color(0xffdddddd),
  onBackground: Color(0xff222222),
  error: Colors.red,
  onError: Colors.white,
  brightness: Brightness.light,
);

const ColorScheme uptimeColorDark = ColorScheme(
  primary: Color(
      0xFF304FFE), // Brighter bluish tint for primary color, less earthy, more vibrant
  onPrimary:
      Color(0xFFFFFFFF), // White, for text/icons on top of the primary color
  secondary: Color(
      0xFF00B0FF), // A vibrant light blue for a playful contrast with the primary color
  onSecondary: Color(
      0xFF000000), // Black, for text/icons on top of the secondary color, ensuring readability
  surface: Color(
      0xFF424242), // A lighter gray for surfaces, contributing to a less serious tone
  onSurface: Color(
      0xDEFFFFFF), // Slightly translucent white, for text/icons on top of the surface color
  background: Color(
      0xFF303030), // Lightening the background slightly to reduce the heaviness
  onBackground: Color(
      0xDEFFFFFF), // Slightly translucent white, for text/icons on top of the background color
  error: Color(
      0xFFF44336), // A brighter red for errors, maintaining visibility but adding vibrancy
  onError: Color(0xFFFFFFFF), // White, for text/icons on top of the error color
  brightness: Brightness.dark, // Indicates this is a dark theme
);

final TextTheme uptimeText = GoogleFonts.orbitronTextTheme();

final ThemeData uptimeLightTheme = ThemeData(
  colorScheme: uptimeColor,
  textTheme: uptimeText,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: OpenUpwardsPageTransitionsBuilder(),
    },
  ),
);

final ThemeData uptimeTheme = ThemeData(
  colorScheme: uptimeColorDark,
  textTheme: uptimeText,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: OpenUpwardsPageTransitionsBuilder(),
    },
  ),
);
