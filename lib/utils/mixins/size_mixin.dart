import 'package:flutter/material.dart';

mixin SizeMixin {
  late double screenHeight;
  late double screenWidth;
  late Size screenSize;
  void setSize(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    screenSize = Size(screenWidth, screenHeight);
  }

  // static Size setConstSize(BuildContext context) {
  //   return Size(
  //       MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
  // }
}
