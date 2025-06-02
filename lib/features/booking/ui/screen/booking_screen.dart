import 'package:axilo/common/methods/common_methods.dart';
import 'package:axilo/common/widgets/bottom_safe_area/bottom_safe_area.dart';
import 'package:axilo/core/model/booking_model.dart';
import 'package:axilo/features/booking/controller/booking_controller.dart';
import 'package:axilo/features/booking/ui/widget/1_booking_service_card.dart';
import 'package:axilo/features/booking/ui/widget/2_booking_service_card_main.dart';
import 'package:axilo/features/booking/ui/widget/3_booking_service_card_buttons.dart';
import 'package:axilo/features/booking/ui/widget/custom_tab_bar.dart';
import 'package:axilo/features/common/ui/widget/review_bootom_sheet.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingController bookController = Get.find<BookingController>();
    return Scaffold(
        appBar: AppBar(
            backgroundColor: WColors.primary,
            foregroundColor: Colors.black,
            surfaceTintColor: Colors.transparent,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text('My Booking'),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(44),
              child: Obx(() {
                return CustomTabBar(tabs: const [
                  'Active',
                  'Completed',
                  'Cancelled',
                ], onTabChanged: bookController.changeTab, selectedIndex: bookController.currentIndex.value);
              }),
            )),
        body: Obx(() {
          bool loading = bookController.isBookLoading.value;
          List<BookingModel> bookedServicesList = bookController.bookedServices;

          if (loading) {
            return Center(
                child: LoadingAnimationWidget.dotsTriangle(
              color: WColors.onPrimary,
              size: 40,
            ));
          }

          if (!loading && bookedServicesList.isEmpty) {
            return Center(
              child: Text("No items booked !!",
                  style: TextStyle(color: WColors.textPrimary, fontWeight: FontWeight.w500, fontSize: 16)),
            );
          }
          return IndexedStack(
            index: bookController.currentIndex.value,
            children: [
              BookingList(
                isActive: true,
              ),
              BookingList(
                isCompleted: true,
              ),
              BookingList(
                isCancelled: true,
              ),
            ],
          );
        }));
  }
}

class BookingList extends StatelessWidget {
  BookingList({this.isActive = false, this.isCompleted = false, this.isCancelled = false, super.key});

  final bool isActive;
  final bool isCompleted;
  final bool isCancelled;

  final BookingController bookController = Get.find<BookingController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final services = isActive
          ? bookController.activeServices
          : isCompleted
              ? bookController.completedServices
              : bookController.cancelledServices;
      return ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          final booking = services[index];
          return BookingServiceCard(
            booking: booking,
            isActive: isActive,
            isCompleted: isCompleted,
            isCancelled: isCancelled,
            onButton1Pressed: isActive
                ? () => _onCancelPressed(booking)
                : isCompleted
                    ? () => _onLeavReviewPressed(booking)
                    : null,
            onButton2Pressed: isActive
                ? onTrackOrderPressed
                : isCompleted
                    ? onEReceiptPressed
                    : null,
          );
        },
      );
    });
  }

  void onTrackOrderPressed() {}

  void _onLeavReviewPressed(BookingModel booking) {
    showReviewBottomSheet(booking.serviceProviderId, booking.serviceProviderName, booking.serviceProviderAddress,
        '${booking.serviceProviderRating} (${booking.numberOfReview})');
  }

  void onEReceiptPressed() {}

  void _onCancelPressed(BookingModel booking) {
    Get.bottomSheet(
      BottomSafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          // constraints: BoxConstraints(maxHeight: Get.height * 0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text('Cancel Service Order?',
                    style: TextStyle(fontSize: 18, color: WColors.textPrimary, fontWeight: FontWeight.w600)),
              ),
              Divider(
                color: Colors.grey[300],
                height: 18,
              ),
              BookingServiceCardMain(booking: booking),
              Obx(() {
                return BookingServiceCardButtons(
                  button1Text: 'Close',
                  button2Text: 'Yes, Cancel',
                  onButton1Pressed: () => Get.back(),
                  onButton2Pressed: () async {
                    await bookController.cancelOrder(booking).then((val) async {
                      if (val) {
                        Get.back();
                        CommonMethods.showSuccessSnackBar('Success', 'Booking cancelled successfully');
                        await bookController.apiCall();
                      }
                    });
                  },
                  buttonEnabled: bookController.isButtonEnabled.value,
                );
              })
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
