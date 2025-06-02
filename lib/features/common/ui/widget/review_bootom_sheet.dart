import 'package:axilo/common/methods/common_methods.dart';
import 'package:axilo/common/widgets/bottom_button_widget/bottom_button_widget.dart';
import 'package:axilo/common/widgets/bottom_safe_area/bottom_safe_area.dart';
import 'package:axilo/features/common/controller/review_controller.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

void showReviewBottomSheet(String providerId, String shopName, String address, String rateAndReview) {
  final reviewController = Get.put(ReviewController());

  Get.bottomSheet(
    BottomSafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Tag and Rating Summary
                  Row(
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: Get.width * 0.41),
                        decoration:
                            BoxDecoration(color: WColors.containerBorder, borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                        child:
                            const Text("Car Washing Service", style: TextStyle(fontSize: 12, color: WColors.onPrimary)),
                      ),
                      Spacer(),
                      Text.rich(
                        TextSpan(
                          children: [
                            const WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Icon(Icons.star_rounded, size: 18, color: Colors.amber)),
                            TextSpan(
                                text: rateAndReview,
                                style: TextStyle(
                                    color: WColors.darkGrey, fontSize: 13.5, height: 1, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Shop Info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(shopName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 24, color: WColors.textPrimary, fontWeight: FontWeight.w700)),
                      Text(address,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: WColors.darkGrey))
                    ],
                  ),

                  Divider(height: 24, color: Colors.grey[300]),

                  // Rating Section
                  Text("Your overall rating of this service provider",
                      style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[600])),
                  SizedBox(height: 12),
                  // Obx(() => Row(
                  //       children: List.generate(5, (index) {
                  //         final selected = reviewController.rating.value > index;
                  //         return IconButton(
                  //           onPressed: () => reviewController.setRating(index + 1),
                  //           icon: Icon(
                  //             selected ? Icons.star : Icons.star_border,
                  //             color: selected ? Colors.amber : Colors.grey,
                  //             size: 32,
                  //           ),
                  //         );
                  //       }),
                  //     )),
                  Align(
                    alignment: Alignment.center,
                    child: RatingBar.builder(
                      minRating: 1,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, index) {
                        final currentRating = reviewController.rating.value;
                        return Icon(
                          index < currentRating ? Icons.star_rounded : Icons.star_border_rounded,
                          color: Colors.amber,
                        );
                      },
                      unratedColor: Colors.amber,
                      onRatingUpdate: (rating) {
                        reviewController.rating.value = rating.toInt();
                      },
                    ),
                  ),

                  Divider(height: 24, color: Colors.grey[300]),

                  // Review Text
                  Text("Add detailed review",
                      style: TextStyle(fontWeight: FontWeight.w500, color: WColors.textPrimary)),
                  SizedBox(height: 8),
                  TextField(
                    controller: reviewController.reviewTextController,
                    minLines: 4,
                    maxLines: 4,
                    style: const TextStyle(color: WColors.textPrimary),
                    decoration: InputDecoration(
                        hintText: "Enter here",
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
                  ),
                ],
              ),
            ),
            BottomButton(
                onPressed: () async {
                  await reviewController.addReview(providerId).then((val) {
                    if (val) {
                      Get.back();
                      CommonMethods.showSuccessSnackBar('Success', 'Review added');
                    }
                  });
                },
                buttonChild: Text(
                  "Continue",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                ))
          ],
        ),
      ),
    ),
    isScrollControlled: true,
  );
}
