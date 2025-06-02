import 'package:axilo/core/theme/app_theme/elevated_button_theme.dart';
import 'package:axilo/core/theme/app_theme/icon_theme.dart';
import 'package:axilo/core/theme/app_theme/text_field_theme.dart';
import 'package:axilo/core/theme/app_theme/text_selection_theme.dart';
import 'package:axilo/core/theme/app_theme/text_theme.dart';
import 'package:axilo/core/theme/app_theme/time_picker_theme.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class WAppTheme {
  WAppTheme._();

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: WColors.softGrey,
    brightness: Brightness.light,
    //primaryColor: WColors.primary,
    textTheme: WTextTheme.ligthTextTheme,
    scaffoldBackgroundColor: WColors.primary,
    iconTheme: WIconTheme.ligthIconTheme,
    textSelectionTheme: WTextSelectionTheme.textSelctionThemeTheme,
    timePickerTheme: WTimePickerTheme.timePickerThemeData,
    // appBarTheme: WAppBarTheme.lightAppBarTheme,
    // checkboxTheme: WCheckboxTheme.lightCheckboxTheme,
    // bottomSheetTheme: WBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: WElevatedButtonTheme.lightElevatedButtonTheme,
    // outlinedButtonTheme: WOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: WTextFormFieldTheme.lightInputDecorationTheme,
  );
}
