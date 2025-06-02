import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class WTextSelectionTheme {
  WTextSelectionTheme._();

  static TextSelectionThemeData textSelctionThemeTheme = const TextSelectionThemeData(
      cursorColor: WColors.onPrimary, // Cursor color
      selectionColor: WColors.onPrimaryBackground, // Highlighted text background
      selectionHandleColor: WColors.onPrimary // Little draggable handles
      );
}
