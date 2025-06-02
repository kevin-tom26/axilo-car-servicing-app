import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class FaqExpansionTile extends StatelessWidget {
  const FaqExpansionTile(
      {super.key,
      required this.titleText,
      required this.childText,
      required this.onExpansionChanged,
      this.initiallyExpanded = false});

  final String titleText;
  final void Function(bool)? onExpansionChanged;
  final bool initiallyExpanded;
  final String childText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 14),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(titleText, style: TextStyle(fontWeight: FontWeight.w500)),
        onExpansionChanged: onExpansionChanged,
        initiallyExpanded: initiallyExpanded,
        minTileHeight: 46,
        iconColor: Colors.purple,
        collapsedIconColor: Colors.purple,
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        children: [Text(childText, maxLines: 4, style: TextStyle(color: WColors.textPrimary))],
      ),
    );
  }
}
