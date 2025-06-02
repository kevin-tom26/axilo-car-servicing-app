import 'package:flutter/material.dart';

class WTimePickerTheme {
  WTimePickerTheme._();

  static TimePickerThemeData timePickerThemeData = TimePickerThemeData(
    helpTextStyle: const TextStyle(
      color: Colors.deepPurple,
      fontWeight: FontWeight.bold,
    ),
    hourMinuteColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.deepPurple.shade100; // background for selected only
      }
      return Colors.transparent; // no background for unselected
    }),
    hourMinuteTextColor: Colors.deepPurple,
    dayPeriodColor: Colors.deepPurple.shade100,
    dayPeriodTextColor: Colors.deepPurple,
    dialHandColor: Colors.deepPurple,
    entryModeIconColor: Colors.deepPurple,
  );
}
