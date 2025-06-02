import 'package:axilo/common/methods/common_methods.dart';
import 'package:axilo/common/widgets/appbar/custom_appbar.dart';
import 'package:axilo/common/widgets/bottom_button_widget/bottom_button_widget.dart';
import 'package:axilo/common/widgets/bottom_safe_area/bottom_safe_area.dart';
import 'package:axilo/features/review_summary/controller/review_summary_controller.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/review_service_card.dart';

class ReviewSummaryScreen extends StatelessWidget {
  ReviewSummaryScreen({super.key});

  final ReviewSummaryController reviewController = Get.put(ReviewSummaryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(onLeadingIconPressed: () => Get.back(), appBarTitle: 'Review Summary'),
      body: BottomSafeArea(
        child: Column(
          children: [
            //
            // Header Section----------------------------------------------------------------------
            //
            ReviewServiceCard(
                name: reviewController.carWashService.name,
                rating: reviewController.carWashService.rating,
                distance: reviewController.carWashService.distance,
                waitTime: reviewController.carWashService.waitTime,
                imagePath: reviewController.carWashService.thumbnail),
            const SizedBox(height: 8),
            Divider(color: Colors.grey[200]),
            //const SizedBox(height: 8),
            //
            // Data Section------------------------------------------------------------------------------------------
            //
            _buildDataRow('Date', '${reviewController.bookingDate} | ${reviewController.bookingTime}'),
            _buildDataRow(
                'Car', '${reviewController.selectedVehicle.type} | ${reviewController.selectedVehicle.plate}'),
            _buildDataRow('Service Type', reviewController.serviceType),
            Divider(color: Colors.grey[200]),
            Expanded(
                child: ListView(
              children: [
                ...reviewController.selectedServices
                    .map((service) => _buildServiceDataRow(service.name, '\$${service.price}')),
                Divider(color: Colors.grey[200]),
                _buildServiceDataRow('Tax & Fees', '\$12.00'),
                Divider(color: Colors.grey[200]),
                _buildServiceDataRow('Total', '\$${reviewController.totalAmount.toStringAsFixed(2)}'),
                Divider(color: Colors.grey[200]),
              ],
            )),
            BottomButton(
                onPressed: () async {
                  await reviewController.bookService();
                  await Future.delayed(Duration(milliseconds: 500));
                  reviewController.makePayment();
                },
                topChildWidget: promoCode(),
                buttonChild: Text("Continue",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: WColors.textSecondary, fontWeight: FontWeight.w500)))
          ],
        ),
      ),
    );
  }

  Widget promoCode() {
    TextEditingController promoCodeController = reviewController.promoCodeController;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextField(
            controller: promoCodeController,
            style: const TextStyle(color: WColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Enter Promo Code',
              hintStyle: const TextStyle(color: WColors.darkerGrey, fontWeight: FontWeight.w400),
              fillColor: Colors.grey.shade200,
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            if (promoCodeController.text.isNotEmpty) {
              reviewController.promoCode.value = promoCodeController.text;
              CommonMethods.showSuccessSnackBar('Success', 'Promo code applied');
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: WColors.onPrimary,
            side: BorderSide.none,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            disabledBackgroundColor: Colors.grey,
          ),
          child: const Text('Apply'),
        ),
      ],
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: Get.width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(label,
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500, color: WColors.darkerGrey.withOpacity(0.8)))),
          Expanded(
              flex: 2,
              child: Text(value,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87))),
        ],
      ),
    );
  }

  Widget _buildServiceDataRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: Get.width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 2,
              child: Text(label,
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500, color: WColors.darkerGrey.withOpacity(0.8)))),
          Expanded(
              child: Text(value,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87))),
        ],
      ),
    );
  }
}
