// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:axilo/common/methods/common_methods.dart';
import 'package:axilo/core/enum/enums.dart';
import 'package:axilo/core/local/local_data.dart';
import 'package:axilo/core/model/booking_model.dart';
import 'package:axilo/core/model/car_wash_model.dart';
import 'package:axilo/features/car_selection/model/vehicle_model.dart';
import 'package:axilo/features/payment/model/stripe_response_model.dart';
import 'package:axilo/features/payment/service/stripe_payment.dart';
import 'package:axilo/features/review_summary/service/review_summary_service.dart';
import 'package:axilo/features/slot_booking/model/user_address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ReviewSummaryController extends GetxController {
  late final CarWashModel carWashService;
  late final String bookingDate;
  late final String bookingTime;
  late final Vehicle selectedVehicle;
  late final String serviceType;
  late final List<Service> selectedServices;
  late final UserAddressModel? selectedAddress;
  late final String extraNote;
  // Rxn<UserAddressModel> pickupDeliveryAddress = Rxn<UserAddressModel>();

  final ReviewSummaryService _reviewSummaryService = ReviewSummaryService();

  final stripePayment = StripePayment();

  Rxn<BookingModel> bookingData = Rxn<BookingModel>();

  final promoCodeController = TextEditingController();

  var promoCode = ''.obs;
  var tax = 12.0;

  @override
  void onInit() {
    super.onInit();
    try {
      final args = Get.arguments;
      if (args != null && args is Map<String, dynamic>) {
        carWashService = args['car_wash_service'];
        bookingDate = args['booking_date'];
        bookingTime = args['booking_time'];
        selectedVehicle = args['selected_vehicle'];
        serviceType = args['service_type'];
        selectedServices = List<Service>.from(args['selected_services']);
        selectedAddress = args['selected_address'];
        extraNote = args['extra_note'];
        //pickupDeliveryAddress = args['pickup_delivery_address'];
      }
    } catch (e) {
      CommonMethods.showErrorSnackBar('Error', 'Failed to get arguments.');
    }
    //paymentServices.phonepeInit();
  }

  @override
  void onClose() {
    promoCodeController.dispose();
    super.onClose();
  }

  double get totalAmount {
    final servicesTotal = selectedServices.fold(0.0, (total, service) => total + service.price);
    return servicesTotal + tax;
  }

  Future<void> bookService() async {
    Map<String, dynamic> data = {
      'user_id': LocalData().userId,
      'order_id': CommonMethods.generateShortUuid(),
      'service_provider_id': carWashService.id,
      'service_provider_name': carWashService.name,
      'service_provider_address': carWashService.address,
      'service_provider_rating': carWashService.rating.toString(),
      'no_of_reviews': carWashService.reviews.length.toString(),
      'thumb_image': carWashService.thumbnail,
      'distance': double.tryParse(carWashService.distance ?? '0'),
      'wait_time': carWashService.waitTime,
      'booked_date': bookingDate,
      'booked_time': bookingDate,
      'vehicle': selectedVehicle.toJson(),
      'service_type': serviceType,
      'pickup_delivery_address': selectedAddress?.toJson(),
      'booked_services': selectedServices.map((s) => s.toJson()).toList(),
      'tax_and_fee': tax,
      'total_amount': totalAmount,
      'promo_code': promoCode.value,
      'extra_note': extraNote,
      'payment_status': PaymentStatus.pending.name,
      'service_status': ServiceStatus.active.name,
    };

    bookingData.value = BookingModel.fromJson(data);
    log('data:\n $data');
    CommonMethods.showLoading();
    try {
      await _reviewSummaryService.bookService(data);
      CommonMethods.hideLoading();
      CommonMethods.showSuccessSnackBar('Success', 'Slot booked successfully');
    } catch (e) {
      final msg = e is FirebaseException ? e.message ?? "Database error" : 'Service booking failed';
      CommonMethods.hideLoading();
      CommonMethods.showErrorSnackBar('Error', msg);
    }
  }

  void makePayment() async {
    StripeResponse response = await stripePayment.makePayment(amount: totalAmount, currency: 'USD');
    CommonMethods.showLoading();
    await updatePaymentStatus(response.status);
    CommonMethods.hideLoading();
    if (response.status == PaymentStatus.success) {
      CommonMethods.showSuccessSnackBar(response.status.name, response.message);
    } else {
      CommonMethods.showErrorSnackBar(response.status.name, response.message);
    }
    CommonMethods.navigateBackToHomeTab();
  }

  Future<void> updatePaymentStatus(PaymentStatus status) async {
    Map<String, dynamic> data = {'payment_status': status.name};
    try {
      await _reviewSummaryService.updateBookig(bookingData.value!.orderId, data);
    } catch (e) {
      final msg = e is FirebaseException ? e.message ?? "Database error" : 'Payment status update failed';
      CommonMethods.showErrorSnackBar('Error', msg);
    }
  }
}
