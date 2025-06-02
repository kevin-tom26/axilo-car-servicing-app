import 'package:axilo/core/local/local_data.dart';
import 'package:axilo/features/bookmark/controller/bookmark_controller.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryFilter extends StatelessWidget {
  CategoryFilter({super.key});

  final BookmarkController bookmarkController = Get.find<BookmarkController>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: ListView.builder(
            itemCount: LocalData.serviceCategories.length + 1,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: Get.width * 0.04),
            itemBuilder: (context, index) {
              return Obx(() {
                final isSelected = bookmarkController.selectedCategoryIndex.value == index;
                final label = index == 0 ? 'All' : LocalData.serviceCategories[index - 1]['name']!;
                return _categoryText(
                  label,
                  isSelected: isSelected,
                  onTap: () => bookmarkController.updateFilterTab(index, label),
                );
              });
            }));
  }

  Widget _categoryText(String filterName, {required bool isSelected, required void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Container(
            decoration: BoxDecoration(
                color: isSelected ? WColors.onPrimary : Colors.grey[300], borderRadius: BorderRadius.circular(17)),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            child: Text(
              filterName,
              style: TextStyle(color: isSelected ? WColors.textSecondary : WColors.textPrimary),
            ),
          ),
        ),
      ),
    );
  }
}
