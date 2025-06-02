import 'package:axilo/common/methods/common_methods.dart';
import 'package:axilo/common/widgets/appbar/custom_appbar.dart';
import 'package:axilo/common/widgets/bottom_button_widget/bottom_button_widget.dart';
import 'package:axilo/common/widgets/bottom_safe_area/bottom_safe_area.dart';
import 'package:axilo/features/slot_booking/controller/slot_booking_controller.dart';
import 'package:axilo/features/slot_booking/ui/widget/date_time_tile_widget.dart';
import 'package:axilo/features/slot_booking/ui/widget/service_estimation_widget.dart';
import 'package:axilo/features/slot_booking/ui/widget/service_type_tile.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SlotBookingScreen extends StatelessWidget {
  SlotBookingScreen({super.key});
  final slotBookingcontroller = Get.put(SlotBookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //Appbar
        appBar: customAppBar(onLeadingIconPressed: () => Get.back(), appBarTitle: 'Book Slot'),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              //Shop name-----------------------------------------------------------------------
              //
              Text(slotBookingcontroller.carWashModelObj.name,
                  style: const TextStyle(fontSize: 20, color: WColors.textPrimary, fontWeight: FontWeight.w600)),
              Text(slotBookingcontroller.carWashModelObj.address,
                  style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500)),
              const SizedBox(height: 26),
              //
              //Service Type-----------------------------------------------------------------------
              //
              const Text("Service Type",
                  style: TextStyle(fontSize: 18, color: WColors.textPrimary, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Row(
                children: [
                  ServiceTypeTile(lable: 'Pick-Up'),
                  const SizedBox(width: 18),
                  ServiceTypeTile(lable: 'Self Service'),
                ],
              ),
              const SizedBox(height: 26),
              //
              //Date and Time picker-----------------------------------------------------------------
              //
              const Text("Date and Time",
                  style: TextStyle(fontSize: 18, color: WColors.textPrimary, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Obx(() {
                      final date = slotBookingcontroller.selectedDate.value;
                      return DateTimeSelectorTile(
                        label: "Date",
                        displayText: date == null ? "Select Date" : formatDateToDayMonth(date),
                        icon: Icons.calendar_month_outlined,
                        onTap: () => _datePicker(context),
                      );
                    }),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Obx(() {
                      final time = slotBookingcontroller.selectedTime.value;
                      return DateTimeSelectorTile(
                        label: "Time",
                        displayText: time == null ? "Select Time" : formatTimeTo12Hr(time),
                        icon: Icons.timer_outlined,
                        onTap: () => _timePicker(context),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 26),
              //
              //Service Estimation time------------------------------------------------------------
              //
              ServiceEstimationWidget(),
              const SizedBox(height: 26),
              //
              //Note provider-------------------------------------------------------------------
              //
              const Text("Note to Service Provider",
                  style: TextStyle(color: WColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 16)),
              const SizedBox(height: 10),
              TextField(
                controller: slotBookingcontroller.noteController,
                minLines: 5,
                maxLines: 5,
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
        bottomNavigationBar: BottomSafeArea(
          child: BottomButton(
              onPressed: () {
                if (slotBookingcontroller.selectedDate.value != null &&
                    slotBookingcontroller.selectedTime.value != null) {
                  if (slotBookingcontroller.selectedServiceType.value == 'Pick-Up') {
                    slotBookingcontroller.goToAddressScreen();
                  } else {
                    slotBookingcontroller.goToReviewSummaryScreen();
                  }
                } else {
                  CommonMethods.showErrorSnackBar('Error', 'Please select a slot Date and Time.');
                  return;
                }
              },
              buttonChild: Text("Continue",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: WColors.textSecondary, fontWeight: FontWeight.w500))),
        ));
  }

  //
  //Date picker method-------------------------------------------------------------------
  //
  void _datePicker(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 6)),
      selectableDayPredicate: (day) {
        final today = DateTime.now();
        return day.isAfter(today.subtract(const Duration(days: 1))) && day.isBefore(today.add(const Duration(days: 7)));
      },
    );
    if (picked != null) {
      slotBookingcontroller.selectedDate.value = picked;
      slotBookingcontroller.selectedDateFormatted = DateFormat('dd MMM, yyyy').format(picked);
    }
  }

  //
  //Time picker-------------------------------------------------------------------
  //
  void _timePicker(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
    );
    if (picked != null && slotBookingcontroller.isTimeValid(picked)) {
      slotBookingcontroller.selectedTime.value = picked;
      slotBookingcontroller.selectedTimeFormatted = formatTimeTo12Hr(picked);
    } else if (picked != null) {
      CommonMethods.showErrorSnackBar("Invalid Time", "Please pick a time between \n9:00 AM and 7:30 PM");
    }
  }

  String formatDateToDayMonth(DateTime date) {
    return DateFormat('dd MMM').format(date);
  }

  String formatTimeTo12Hr(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('hh:mm a').format(dt);
  }
}
