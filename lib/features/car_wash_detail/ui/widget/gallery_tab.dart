import 'package:axilo/utils/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GalleryTab extends StatelessWidget {
  final List<String> galleryList;
  const GalleryTab({
    super.key,
    required this.galleryList,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        delegate: SliverChildBuilderDelegate(
          childCount: galleryList.length, // Number of items in the grid
          (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(galleryList[index]),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class GalleryTabHeading extends StatelessWidget {
  final int imageCount;
  const GalleryTabHeading({
    super.key,
    required this.imageCount,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Get.width * 0.04,
        ),
        padding: EdgeInsets.only(top: Get.height * 0.02),
        child: Text.rich(TextSpan(children: [
          TextSpan(
            text: 'Gallery',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: WColors.textPrimary),
          ),
          TextSpan(
            text: ' $imageCount',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: WColors.onPrimary),
          ),
        ])),
      ),
    );
  }
}
