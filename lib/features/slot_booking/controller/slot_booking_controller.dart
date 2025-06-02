// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:axilo/core/model/car_wash_model.dart';
import 'package:axilo/features/car_selection/controller/car_selection_controller.dart';
import 'package:axilo/features/car_selection/model/vehicle_model.dart';
import 'package:axilo/features/service_selection/controller/service_selection_controller.dart';
import 'package:axilo/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../car_wash_detail/controller/car_wash_detail_controller.dart';

class SlotBookingController extends GetxController {
  late CarWashDetailController carDetailController;
  late ServiceSelectionController serviceSelectionController;
  late CarSelectionController vehicleController;
  var isAddressLoading = true.obs;

  @override
  void onInit() {
    super.onInit();

    carDetailController = Get.find<CarWashDetailController>();
    serviceSelectionController = Get.find<ServiceSelectionController>();
    vehicleController = Get.find<CarSelectionController>();
  }

  @override
  void onClose() {
    noteController.dispose();
    typeController.dispose();
    addressController.dispose();
    super.onClose();
  }

  var selectedServiceType = 'Pick-Up'.obs;
  var selectedDate = Rxn<DateTime>();
  var selectedTime = Rxn<TimeOfDay>();
  var note = ''.obs;

  String? selectedDateFormatted;
  String? selectedTimeFormatted;

  final TextEditingController noteController = TextEditingController();
  final typeController = TextEditingController();
  final addressController = TextEditingController();

  List<String> services = ['Pick-Up', 'Self Service'];

  List<DateTime> get availableDates {
    final today = DateTime.now();
    return List.generate(7, (i) => today.add(Duration(days: i)));
  }

  bool isTimeValid(TimeOfDay time) {
    const start = TimeOfDay(hour: 9, minute: 0);
    const end = TimeOfDay(hour: 19, minute: 30);
    final totalMinutes = time.hour * 60 + time.minute;
    return totalMinutes >= start.hour * 60 + start.minute && totalMinutes <= end.hour * 60 + end.minute;
  }

  String get formattedDuration =>
      "Estimated Service Duration: ${(serviceSelectionController.durationTotal / 60).toStringAsFixed(2)} Hours";

  CarWashModel get carWashModelObj => carDetailController.carWashModelObj;

  Vehicle get selectedVehicle => vehicleController.selectedVehicle.value!;

  List<Service> get selectedService => serviceSelectionController.selectedServices;

  void goToAddressScreen() {
    Get.toNamed(AppRoutes.pick_up_addrees_screen, arguments: {
      'car_wash_service': carDetailController.carWashModelObj,
      'booking_date': selectedDateFormatted,
      'booking_time': selectedDateFormatted,
      'selected_vehicle': vehicleController.selectedVehicle.value,
      'service_type': selectedServiceType.value,
      'selected_services': serviceSelectionController.selectedServices.toList(),
      'extra_note': noteController.text.trim(),
      //  'pickup_delivery_address': selectedAddress
    });
  }

  void goToReviewSummaryScreen() {
    Get.toNamed(AppRoutes.review_summary_screen, arguments: {
      'car_wash_service': carDetailController.carWashModelObj,
      'booking_date': selectedDateFormatted,
      'booking_time': selectedDateFormatted,
      'selected_vehicle': vehicleController.selectedVehicle.value,
      'service_type': selectedServiceType.value,
      'selected_services': serviceSelectionController.selectedServices.toList(),
      // 'selected_address': selectedAddress.value,
      'extra_note': noteController.text.trim(),
      //  'pickup_delivery_address': selectedAddress
    });
  }
}
