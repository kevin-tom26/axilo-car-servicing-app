import 'package:axilo/utils/constants/colors.dart';
import 'package:axilo/utils/constants/image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ReviewServiceCard extends StatelessWidget {
  const ReviewServiceCard({
    super.key,
    required this.name,
    required this.rating,
    required this.distance,
    required this.waitTime,
    required this.imagePath,
  });

  final String name;
  final double rating;
  final String? distance;
  final int waitTime;

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: 8),
      child: SizedBox(
        height: 150,
        child: _buildCardContent(context),
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
        padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
        child: ClipRRect(
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
                ))));
  }

  Widget _buildServiceInfo(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: Get.width * 0.41),
                  decoration: BoxDecoration(color: WColors.containerBorder, borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  child: const Text("Car Washing", style: TextStyle(fontSize: 12, color: WColors.onPrimary)),
                ),
                Container(
                    decoration: BoxDecoration(color: WColors.lightContainer, borderRadius: BorderRadius.circular(6)),
                    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    margin: const EdgeInsets.only(right: 8),
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
                    ))
              ],
            ),
            const SizedBox(height: 10),
            Text(name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontSize: 18, color: WColors.textPrimary, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.location_on_rounded, size: 24, color: WColors.onPrimary),
                Text('$distance Km',
                    style: const TextStyle(fontSize: 14, color: WColors.darkGrey, fontWeight: FontWeight.w500)),
                const SizedBox(width: 14),
                SvgPicture.asset(
                  WImages.clock,
                  width: 18,
                  height: 18,
                  colorFilter: const ColorFilter.mode(WColors.onPrimary, BlendMode.srcIn),
                ),
                const SizedBox(width: 4),
                Text('$waitTime Mins',
                    style: const TextStyle(fontSize: 14, color: WColors.darkGrey, fontWeight: FontWeight.w500)),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
