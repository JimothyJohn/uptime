import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Created with https://m2.material.io/design/color/the-color-system.html#tools-for-picking-colors
const ColorScheme uptimeColor = ColorScheme(
  primary: Color(0xdddddddd),
  onPrimary: Color(0x22222222),
  secondary: Color(0xdddddddd),
  onSecondary: Color(0x22222222),
  surface: Color(0xdddddddd),
  onSurface: Color(0x22222222),
  background: Color(0xdddddddd),
  onBackground: Color(0x22222222),
  error: Colors.red,
  onError: Colors.white,
  brightness: Brightness.light,
);

const ColorScheme uptimeDarkColor = ColorScheme(
  primary: Color(0xdddddddd),
  onPrimary: Color(0x22222222),
  secondary: Color(0xdddddddd),
  onSecondary: Color(0x22222222),
  surface: Color(0xdddddddd),
  onSurface: Color(0x22222222),
  background: Color(0xdddddddd),
  onBackground: Color(0x22222222),
  error: Colors.red,
  onError: Colors.white,
  brightness: Brightness.light,
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
  colorScheme: uptimeColor,
  textTheme: uptimeText,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: OpenUpwardsPageTransitionsBuilder(),
    },
  ),
);
