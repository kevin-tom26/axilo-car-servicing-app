import 'package:axilo/core/model/booking_model.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:axilo/utils/constants/image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BookingServiceCardMain extends StatelessWidget {
  const BookingServiceCardMain({super.key, required this.booking});
  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        child: Row(
          children: [
            _buildImage(context),
            _buildServiceInfo(context),
          ],
        ));
  }

  Widget _buildImage(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AspectRatio(
                aspectRatio: 0.93,
                child: CachedNetworkImage(
                  imageUrl: booking.thumbImage,
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
            Container(
              constraints: BoxConstraints(maxWidth: Get.width * 0.41),
              decoration: BoxDecoration(color: WColors.containerBorder, borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              child: const Text("Car Washing Service", style: TextStyle(fontSize: 12, color: WColors.onPrimary)),
            ),
            const SizedBox(height: 10),
            Text(booking.serviceProviderName,
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
                Text('${booking.distance} Km',
                    style: const TextStyle(fontSize: 14, color: WColors.darkGrey, fontWeight: FontWeight.w500)),
                const SizedBox(width: 14),
                SvgPicture.asset(
                  WImages.clock,
                  width: 18,
                  height: 18,
                  colorFilter: const ColorFilter.mode(WColors.onPrimary, BlendMode.srcIn),
                ),
                const SizedBox(width: 4),
                Text('${booking.waitTime} Mins',
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
