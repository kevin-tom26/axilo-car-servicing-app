import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AppbarIcon extends StatelessWidget {
  final String assetImage;
  final double? scale;
  final Color? backgroundColor;
  final void Function()? onPressed;
  const AppbarIcon(
      {super.key,
      required this.assetImage,
      this.scale = 1,
      this.backgroundColor = WColors.primary,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
        onPressed: onPressed,
        icon: Image.asset(
          assetImage,
          scale: scale,
        ),
        style: IconButton.styleFrom(
          backgroundColor: backgroundColor,
          shadowColor: WColors.pureblack,
          elevation: 6,
        ));
  }
}
