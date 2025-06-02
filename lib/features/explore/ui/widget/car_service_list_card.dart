import 'package:auto_size_text/auto_size_text.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CarServiceListCard extends StatelessWidget {
  const CarServiceListCard({
    super.key,
    required this.context,
    required this.image,
    required this.name,
    required this.distance,
    required this.waitTime,
    required this.minPrice,
    required this.maxPrice,
    required this.rating,
  });

  final BuildContext context;
  final String image;
  final String name;
  final String? distance;

  final double waitTime;
  final double minPrice;
  final double maxPrice;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: WColors.buttonBlack, blurRadius: 5, spreadRadius: 0, offset: Offset(1.5, 0.5))
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: WColors.primary,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              carWashCardImage(context),
              const Spacer(),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    companyName(context),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              distanceAndAddressSection(context),
                              scheduleSection(context),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        priceSection(context),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget carWashCardImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, top: 4),
      child: Stack(
        children: [
          SizedBox(
              height: Get.height * 0.15,
              width: double.infinity,
              child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: image,
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
            top: 10,
            right: 12,
            child: Container(
              decoration: BoxDecoration(
                color: WColors.lightContainer,
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              child: Text.rich(
                TextSpan(
                  children: [
                    const WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Icon(
                        Icons.star_rounded,
                        size: 18,
                        color: Color.fromARGB(255, 232, 211, 16),
                      ),
                    ),
                    // const WidgetSpan(child: SizedBox(width: 2)),
                    TextSpan(
                        text: ' $rating ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: WColors.textPrimary, fontWeight: FontWeight.w600)),
                  ],
                ),
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget companyName(BuildContext context) {
    return Text(
      name,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: WColors.textPrimary, fontWeight: FontWeight.w600),
    );
  }

  Widget distanceAndAddressSection(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Icon(
              Icons.location_on_outlined,
              size: 18,
              color: WColors.iconBlack,
            ),
          ),
          //const WidgetSpan(child: SizedBox(width: 2)),
          TextSpan(text: distance != null ? '$distance Km' : "-", style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget scheduleSection(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Icon(
              Icons.schedule_outlined,
              size: 16,
              color: WColors.iconBlack,
            ),
          ),
          const WidgetSpan(child: SizedBox(width: 4)),
          TextSpan(text: 'Wait time: $waitTime', style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget priceSection(BuildContext context) {
    return AutoSizeText(
      '\$$minPrice - \$$maxPrice',
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: const Color.fromARGB(255, 0, 94, 255), fontFamily: "OswaldRegular", fontWeight: FontWeight.w600),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      minFontSize: 14,
      maxFontSize: 16,
    );
  }
}
