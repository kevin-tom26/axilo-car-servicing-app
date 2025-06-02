import 'package:axilo/features/slot_booking/controller/slot_booking_controller.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceEstimationWidget extends StatelessWidget {
  ServiceEstimationWidget({super.key});

  final SlotBookingController slotBookingcontroller = Get.find<SlotBookingController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(25),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            const VerticalDivider(
              color: WColors.onPrimary,
              thickness: 3,
              width: 0, // includes spacing
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                slotBookingcontroller.formattedDuration,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade800, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
