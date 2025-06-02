import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTabBar extends StatefulWidget {
  final List<String> tabs;
  final ValueChanged<int> onTabChanged;
  final int selectedIndex;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.onTabChanged,
    required this.selectedIndex,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Row(
        children: List.generate(widget.tabs.length, (index) {
          final bool isSelected = index == widget.selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => widget.onTabChanged(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.tabs[index],
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: isSelected ? WColors.onPrimary : WColors.darkerGrey, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5, left: 6, right: 6),
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      color: isSelected ? WColors.onPrimary : Colors.transparent,
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
