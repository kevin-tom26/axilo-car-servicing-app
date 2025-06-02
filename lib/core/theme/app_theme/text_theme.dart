import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class WTextTheme {
  WTextTheme._();

  static TextTheme ligthTextTheme = const TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headlineSmall: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w700,
      color: WColors.textSecondary,
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: WColors.textPrimary,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: WColors.textSecondary,
    ),
    bodyMedium: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: WColors.textSecondary, overflow: TextOverflow.ellipsis),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: WColors.textSecondary,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: WColors.textPrimary,
    ),
  );
}
