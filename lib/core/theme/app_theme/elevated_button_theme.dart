import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class WElevatedButtonTheme {
  WElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: WColors.textSecondary,
      backgroundColor: WColors.onPrimary,
      disabledBackgroundColor: Colors.grey,
      // disabledForegroundColor: TColors.darkGrey,
      // disabledBackgroundColor: TColors.buttonDisabled,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      side: const BorderSide(color: WColors.onPrimary),
      textStyle: const TextStyle(fontSize: 14, color: WColors.textSecondary, fontWeight: FontWeight.w400),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
  );
}
