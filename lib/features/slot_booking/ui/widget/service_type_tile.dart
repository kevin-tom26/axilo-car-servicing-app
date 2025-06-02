import 'package:axilo/features/slot_booking/controller/slot_booking_controller.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceTypeTile extends StatelessWidget {
  final String lable;

  ServiceTypeTile({
    super.key,
    required this.lable,
  });

  final SlotBookingController slotBookingcontroller = Get.find<SlotBookingController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Expanded(
        child: GestureDetector(
          onTap: () => slotBookingcontroller.selectedServiceType.value = lable,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color:
                  slotBookingcontroller.selectedServiceType.value == lable ? WColors.onPrimary : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(25),
            ),
            alignment: Alignment.center,
            child: Text(
              lable,
              style: TextStyle(
                fontSize: 15,
                color: slotBookingcontroller.selectedServiceType.value == lable ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    });
  }
}
