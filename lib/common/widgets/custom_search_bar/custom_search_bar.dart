import 'dart:async';

import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class CustomSerachBar<T> extends StatelessWidget {
  final String hintText;
  final TextStyle? hintStyle;
  final bool borderEnabled;
  final bool marginEnabled;
  final Color? fillColor;
  final FutureOr<List<T>> Function(String) suggestionsCallback;
  final Widget Function(BuildContext, T) itemBuilder;
  final void Function(T) onSelected;
  final void Function(TextEditingController controller)? onControllerReady;
  final SuggestionsController<T>? suggestionsController;

  const CustomSerachBar(
      {super.key,
      required this.hintText,
      this.hintStyle,
      this.borderEnabled = false,
      this.marginEnabled = true,
      this.fillColor,
      required this.suggestionsCallback,
      required this.itemBuilder,
      required this.onSelected,
      required this.onControllerReady,
      this.suggestionsController});

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<T>(
      suggestionsCallback: suggestionsCallback,
      suggestionsController: suggestionsController,
      itemBuilder: itemBuilder,
      onSelected: (value) {
        onSelected(value);
      },
      builder: (context, internalController, internalFocusNode) {
        onControllerReady?.call(internalController);
        return Container(
            margin: marginEnabled ? EdgeInsets.symmetric(horizontal: Get.width * 0.04) : null,
            child: TextField(
              controller: internalController,
              focusNode: internalFocusNode,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: WColors.textPrimary,
                  ),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: borderEnabled ? WColors.onPrimary : Colors.black,
                  ),
                  fillColor: fillColor ?? Colors.grey[200],
                  hintText: hintText,
                  hintStyle: hintStyle ?? const TextStyle(color: WColors.darkGrey, fontSize: 14),
                  enabledBorder: borderEnabled
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.black))
                      : null,
                  focusedBorder: borderEnabled
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: WColors.onPrimary, width: 1.5))
                      : null),
            ));
      },
      decorationBuilder: (context, child) {
        return Container(
          margin: marginEnabled ? EdgeInsets.symmetric(horizontal: Get.width * 0.04) : null,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: WColors.onPrimary.withOpacity(0.4), width: 0),
            boxShadow: [
              BoxShadow(
                color: WColors.onPrimary.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: child,
        );
      },
      hideOnEmpty: false,
      hideWithKeyboard: false,
      constraints: BoxConstraints(maxHeight: Get.height * 0.308),
    );
  }
}
