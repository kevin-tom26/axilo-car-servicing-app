import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
        child: TextField(
          //controller: searchController,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: WColors.textPrimary,
              ),
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search_rounded),
              fillColor: Colors.grey[200],
              hintText: "Search",
              hintStyle: const TextStyle(color: WColors.darkGrey, fontSize: 14)),
        ));
  }
}
