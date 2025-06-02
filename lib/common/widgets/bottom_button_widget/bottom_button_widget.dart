import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? topChildWidget;
  final Widget? buttonChild;
  const BottomButton({super.key, required this.onPressed, this.topChildWidget, required this.buttonChild});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (topChildWidget != null) topChildWidget!,
          if (topChildWidget != null) const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
              child: buttonChild,
            ),
          ),
        ],
      ),
    );
  }
}
