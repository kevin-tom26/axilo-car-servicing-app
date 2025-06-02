import 'package:axilo/utils/constants/colors.dart';
import 'package:axilo/utils/constants/image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class AboutTab extends StatelessWidget {
  final String aboutText;
  final String providerImage;
  final String providerName;
  final String providerPosition;
  final void Function()? onSendPressed;
  final void Function()? onPhonePressed;
  const AboutTab({
    super.key,
    required this.aboutText,
    required this.providerImage,
    required this.providerName,
    required this.providerPosition,
    this.onSendPressed,
    this.onPhonePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            ReadMoreText(
              aboutText,
              trimMode: TrimMode.Line,
              trimLines: 3,
              trimCollapsedText: 'Read more',
              trimExpandedText: 'Read less',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: WColors.textPrimary,
              ),
              moreStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: WColors.onPrimary, fontWeight: FontWeight.w600),
              lessStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: WColors.onPrimary, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: Get.height * 0.03),
            Text(
              'Service Provider',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(color: WColors.textPrimary),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: CachedNetworkImageProvider(providerImage),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        providerName,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: WColors.textPrimary, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        providerPosition,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: WColors.darkGrey, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                //Spacer(),
                IconButton.filled(
                  icon: Image.asset(
                    WImages.send,
                    scale: 1.2,
                    color: WColors.onPrimary,
                  ),
                  style: IconButton.styleFrom(backgroundColor: WColors.softGrey),
                  onPressed: onSendPressed,
                ),
                IconButton(
                  icon: Image.asset(
                    WImages.phone,
                    scale: 1.2,
                    color: WColors.onPrimary,
                  ),
                  style: IconButton.styleFrom(backgroundColor: WColors.softGrey),
                  onPressed: onPhonePressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AboutTabHeading extends StatelessWidget {
  const AboutTabHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Get.width * 0.04,
        ),
        padding: EdgeInsets.only(top: Get.height * 0.02),
        child: Text(
          'About',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: WColors.textPrimary),
        ),
      ),
    );
  }
}
