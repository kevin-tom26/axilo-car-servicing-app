import 'dart:async';

import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class CustomTypeAhead<T> extends StatelessWidget {
  final String hintText;
  final bool enabled;
  final FutureOr<List<T>> Function(String) suggestionsCallback;
  final Widget Function(BuildContext, T) itemBuilder;
  final void Function(T) onSelected;
  final void Function(TextEditingController controller)? onControllerReady;
  final SuggestionsController<T>? suggestionsController;

  const CustomTypeAhead(
      {super.key,
      required this.hintText,
      this.enabled = true,
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

        return TextField(
          controller: internalController,
          focusNode: internalFocusNode,
          style: const TextStyle(color: WColors.textPrimary),
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: WColors.darkerGrey, fontWeight: FontWeight.w400),
              fillColor: WColors.darkGrey.withOpacity(0.2),
              suffixIcon: Icon(Icons.arrow_forward_ios_rounded,
                  color: enabled ? WColors.onPrimary : WColors.darkGrey.withOpacity(0.4)),
              enabled: enabled,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: WColors.onPrimary, width: 0.5)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: WColors.onPrimary))),
        );
      },
      decorationBuilder: (context, child) {
        return Container(
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
