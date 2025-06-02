import 'package:axilo/features/car_wash_detail/ui/widget/appbar_icon.dart';
import 'package:axilo/utils/constants/image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarWashDetailAppBar extends StatelessWidget {
  final String backgroundImage;
  final void Function()? onBackPressed;
  final void Function()? onSharePressed;
  final void Function()? onBookmarkPressed;
  const CarWashDetailAppBar(
      {super.key,
      required this.backgroundImage,
      required this.onBackPressed,
      required this.onSharePressed,
      required this.onBookmarkPressed});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: Get.height * 0.3,
      pinned: true,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: CachedNetworkImageProvider(backgroundImage), fit: BoxFit.cover)),
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.035, vertical: Get.width * 0.035),
          child: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppbarIcon(
                  assetImage: WImages.back24,
                  scale: 1.1,
                  onPressed: onBackPressed,
                ),
                const Spacer(),
                AppbarIcon(
                  assetImage: WImages.share24,
                  scale: 1.3,
                  onPressed: onSharePressed,
                ),
                AppbarIcon(
                  assetImage: WImages.bookmark24,
                  scale: 1.05,
                  onPressed: onBookmarkPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
