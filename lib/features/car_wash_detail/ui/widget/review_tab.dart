import 'package:axilo/common/methods/common_methods.dart';
import 'package:axilo/core/model/car_wash_model.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:axilo/utils/constants/image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ReviewTab extends StatelessWidget {
  final List<Review> reviews;
  const ReviewTab({
    super.key,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: reviews.length, (context, index) {
      return Card(
        elevation: 3,
        color: WColors.softGrey,
        margin: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: Get.width * 0.04,
        ),
        child: Container(
          constraints: BoxConstraints(maxHeight: Get.height * 0.25, minHeight: Get.height * 0.07),
          padding: const EdgeInsets.all(8),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.07,
                  child: Row(children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        // height: Get.height * 0.08,
                        // width: Get.height * 0.08,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: WColors.mainContainer,
                            image: DecorationImage(
                                image: reviews[index].profileImg != null
                                    ? CachedNetworkImageProvider(reviews[index].profileImg!)
                                    : AssetImage(WImages.profile_pic) as ImageProvider,
                                fit: BoxFit.cover)),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            reviews[index].reviewerName,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: WColors.textPrimary),
                          ),
                          RatingBarIndicator(
                            rating: reviews[index].rating.toDouble(),
                            itemBuilder: (context, indx) => Icon(
                              indx < reviews[index].rating ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                            ),
                            unratedColor: Colors.amber,
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      CommonMethods.timeDiff(reviews[index].date),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: WColors.darkGrey),
                    ),
                  ]),
                ),

                const SizedBox(height: 4),
                // Comment Text
                Text(
                  reviews[index].comment,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: WColors.textPrimary),
                  softWrap: true,
                  maxLines: 6,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      );
    }));
  }
}

class ReviewTabHeading extends StatelessWidget {
  final Function()? onAddReview;
  const ReviewTabHeading({
    super.key,
    this.onAddReview,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Get.width * 0.04,
        ),
        padding: EdgeInsets.only(top: Get.height * 0.02),
        child: Row(
          children: [
            Text(
              'Reviews',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(color: WColors.textPrimary),
            ),
            const Spacer(),
            GestureDetector(
              onTap: onAddReview,
              child: Text.rich(TextSpan(children: [
                const WidgetSpan(
                    child: Icon(
                  Icons.border_color_rounded,
                  color: WColors.onPrimary,
                )),
                TextSpan(
                  text: 'add review',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.w500, color: WColors.onPrimary),
                )
              ])),
            ),
          ],
        ),
      ),
    );
  }
}
