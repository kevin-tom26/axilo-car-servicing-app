import 'package:axilo/common/methods/common_methods.dart';
import 'package:axilo/core/enum/enums.dart';
import 'package:axilo/core/model/booking_model.dart';
import 'package:axilo/features/booking/ui/widget/3_booking_service_card_buttons.dart';
import 'package:axilo/features/booking/ui/widget/2_booking_service_card_main.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingServiceCard extends StatelessWidget {
  const BookingServiceCard(
      {required this.booking,
      required this.onButton1Pressed,
      required this.onButton2Pressed,
      this.isActive = false,
      this.isCompleted = false,
      this.isCancelled = false,
      super.key});

  final BookingModel booking;
  final void Function()? onButton1Pressed;
  final void Function()? onButton2Pressed;
  final bool isActive;
  final bool isCompleted;
  final bool isCancelled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: 8),
      child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: WColors.offWhite,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 10, offset: Offset(2, 2))]),
          child: _buildCardContent(context)),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _serviceStatus(
          isCompleted
              ? "Order Completed"
              : isCancelled
                  ? "Cancelled"
                  : (isActive &&
                          (booking.paymentStatus == PaymentStatus.pending.name ||
                              booking.paymentStatus == PaymentStatus.failure.name))
                      ? "Order Pending"
                      : "Order Accepted",
          isCompleted
              ? WColors.info
              : isCancelled
                  ? WColors.error
                  : (isActive &&
                          (booking.paymentStatus == PaymentStatus.pending.name ||
                              booking.paymentStatus == PaymentStatus.failure.name))
                      ? WColors.warning
                      : WColors.success,
        ),
        SizedBox(height: 8),
        BookingServiceCardMain(booking: booking),
        if (!isCancelled) ...[
          SizedBox(height: 4),
          Row(
            children: [
              Expanded(flex: 4, child: _bookedServiceDetails('Order ID', '#${booking.orderId}')),
              SizedBox(width: 8),
              Expanded(
                  flex: 3, child: _bookedServiceDetails('Order Date', CommonMethods.formatDate(booking.bookedDate))),
              SizedBox(width: 8),
              Expanded(flex: 4, child: _bookedServiceDetails('Total Payment', '\$${booking.totalAmount}'))
            ],
          ),
          Divider(
            color: Colors.grey[300],
            height: 18,
          ),
          BookingServiceCardButtons(
              button1Text: isActive ? 'Cancel' : 'Leave Review',
              button2Text: isActive ? 'Track Order' : 'E-Receipt',
              onButton1Pressed: onButton1Pressed,
              onButton2Pressed: onButton2Pressed)
        ]
      ],
    );
  }

  Widget _serviceStatus(String status, Color color) {
    return Container(
      constraints: BoxConstraints(maxWidth: Get.width * 0.41),
      decoration: BoxDecoration(color: WColors.containerBorder, borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Text(status, style: TextStyle(fontSize: 12.5, color: color, fontWeight: FontWeight.w500)),
    );
  }

  Widget _bookedServiceDetails(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),
        ),
        Text(subtitle,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: WColors.textPrimary, fontSize: 15, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
