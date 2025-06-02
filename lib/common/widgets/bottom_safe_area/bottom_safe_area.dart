import 'package:flutter/material.dart';

class BottomSafeArea extends StatelessWidget {
  final bool bottom;
  final Widget child;

  const BottomSafeArea({super.key, required this.child, this.bottom = true});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      left: false,
      right: false,
      bottom: true,
      child: child,
    );
  }
}
