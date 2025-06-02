import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarWashSectionHeading extends StatelessWidget {
  const CarWashSectionHeading({
    super.key,
    required this.sectionHeading,
    required this.onSeeAll,
  });

  final String sectionHeading;
  final void Function()? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Get.width * 0.04,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(sectionHeading, style: Theme.of(context).textTheme.titleLarge),
                GestureDetector(
                  onTap: onSeeAll,
                  child: Text(
                    "See All",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: WColors.onPrimary,
                        ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}
