import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class WTextFormFieldTheme {
  WTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
      errorMaxLines: 3,
      prefixIconColor: WColors.iconBlack,
      suffixIconColor: WColors.iconBlack,
      //constraints: const BoxConstraints.expand(height: 20),
      // labelStyle: const TextStyle()
      //     .copyWith(fontSize: TSizes.fontSizeMd, color: TColors.black),
      hintStyle: const TextStyle().copyWith(fontSize: 16, color: WColors.textPrimary),
      errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),

      // floatingLabelStyle:
      //     const TextStyle().copyWith(color: TColors.black.withOpacity(0.8)),
      filled: true,
      fillColor: WColors.lightContainer,
      border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(width: 1, color: WColors.onPrimary),
      ),
      errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(width: 1, color: WColors.error),
      ),
      focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(width: 2, color: WColors.warning),
      ),
      disabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15));
}
