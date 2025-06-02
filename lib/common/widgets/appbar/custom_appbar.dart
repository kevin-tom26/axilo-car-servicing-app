import 'package:axilo/utils/constants/colors.dart';
import 'package:axilo/utils/constants/image.dart';
import 'package:flutter/material.dart';

AppBar customAppBar(
    {Widget? leadingIcon,
    required void Function()? onLeadingIconPressed,
    String appBarTitle = '',
    List<Widget>? actions,
    Widget? titleWidget,
    PreferredSizeWidget? bottom,
    bool transparent = false}) {
  return AppBar(
      backgroundColor: transparent ? Colors.transparent : WColors.primary,
      foregroundColor: Colors.black,
      leading: IconButton.filled(
        onPressed: onLeadingIconPressed,
        icon: leadingIcon ?? Image.asset(WImages.back24, scale: 1.1),
        style: IconButton.styleFrom(
            backgroundColor: WColors.primary, side: const BorderSide(color: WColors.mainContainer)),
      ),
      leadingWidth: 70,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: titleWidget ?? Text(appBarTitle),
      actions: actions,
      bottom: bottom);
}
