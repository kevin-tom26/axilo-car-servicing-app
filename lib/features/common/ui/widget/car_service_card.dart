import 'package:auto_size_text/auto_size_text.dart';
import 'package:axilo/features/common/controller/service_card_controller.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:axilo/utils/constants/image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ServiceCard extends StatelessWidget {
  ServiceCard(
      {super.key,
      required this.id,
      required this.name,
      required this.rating,
      required this.distance,
      required this.waitTime,
      required this.minPrice,
      required this.maxPrice,
      required this.imagePath,
      required this.onTap});

  final String id;
  final String name;
  final double rating;
  final String? distance;
  final int waitTime;
  final double minPrice;
  final double maxPrice;
  final String imagePath;
  final void Function()? onTap;

  final ServiceCardController serviceCardController = Get.put(ServiceCardController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: Get.width * 0.04),
        decoration: BoxDecoration(
          color: WColors.offWhite,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        height: 150,
        child: Stack(
          children: [_buildCardContent(context), _buildBookmarkButton(serviceCardController)],
        ),
      ),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    return Row(
      children: [
        _buildImageWithRating(context),
        _buildServiceInfo(context),
      ],
    );
  }

  Widget _buildImageWithRating(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AspectRatio(
                  aspectRatio: 0.93,
                  child: CachedNetworkImage(
                    imageUrl: imagePath,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                        child: LoadingAnimationWidget.dotsTriangle(
                      color: WColors.onPrimary,
                      size: 35,
                    )),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.broken_image,
                      color: WColors.black,
                    ),
                  ))),
          Positioned(
              top: 8,
              left: 8,
              child: Container(
                  decoration: BoxDecoration(color: WColors.lightContainer, borderRadius: BorderRadius.circular(6)),
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  child: Text.rich(
                    TextSpan(children: [
                      const WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: Colors.amber,
                          )),
                      TextSpan(
                          text: ' $rating ',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: WColors.textPrimary, fontSize: 13, fontWeight: FontWeight.w600))
                    ]),
                    maxLines: 1,
                  )))
        ]));
  }

  Widget _buildServiceInfo(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Container(
              constraints: BoxConstraints(maxWidth: Get.width * 0.41),
              decoration: BoxDecoration(color: WColors.containerBorder, borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              child: const Text("Car Washing Service", style: TextStyle(fontSize: 12, color: WColors.onPrimary)),
            ),
            const SizedBox(height: 6),
            Text(name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: WColors.textPrimary, fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.location_on_rounded, size: 21, color: WColors.onPrimary),
                Text('$distance Km', style: const TextStyle(fontSize: 13.5, color: WColors.darkGrey)),
                const SizedBox(width: 14),
                SvgPicture.asset(
                  WImages.clock,
                  width: 16,
                  height: 16,
                  colorFilter: const ColorFilter.mode(WColors.onPrimary, BlendMode.srcIn),
                ),
                const SizedBox(width: 4),
                Text('$waitTime Mins', style: const TextStyle(fontSize: 13.5, color: WColors.darkGrey)),
              ],
            ),
            const SizedBox(height: 8),
            AutoSizeText.rich(
              TextSpan(children: [
                TextSpan(
                  text: '$minPrice-$maxPrice',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: WColors.onPrimary, fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: '/Service',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 11, color: WColors.darkGrey, fontWeight: FontWeight.w500),
                )
              ]),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              minFontSize: 11,
              maxFontSize: 16,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildBookmarkButton(ServiceCardController serviceCardController) {
    return Positioned(
      top: 10,
      right: 10,
      child: Obx(() {
        return GestureDetector(
          onTap: () {
            serviceCardController.isBookmarked(id)
                ? serviceCardController.removeFromBookmark(id)
                : serviceCardController.addToBookmark(id);
          },
          child: serviceCardController.isBookmarked(id)
              ? SvgPicture.asset(WImages.bookmarked32,
                  colorFilter: const ColorFilter.mode(WColors.onPrimary, BlendMode.srcIn))
              : SvgPicture.asset(
                  WImages.bookmark32,
                ),
        );
      }),
    );
  }
}
