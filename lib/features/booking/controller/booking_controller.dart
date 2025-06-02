import 'package:axilo/common/methods/common_methods.dart';
import 'package:axilo/core/enum/enums.dart';
import 'package:axilo/core/model/booking_model.dart';
import 'package:axilo/features/booking/service/booking_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  final BookingService _bookingService = BookingService();
  RxList<BookingModel> bookedServices = <BookingModel>[].obs;
  RxList<BookingModel> cancelledServices = <BookingModel>[].obs;
  RxList<BookingModel> activeServices = <BookingModel>[].obs;
  RxList<BookingModel> completedServices = <BookingModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    apiCall();
  }

  var currentIndex = 0.obs;
  var isBookLoading = true.obs;
  var isButtonEnabled = true.obs;

  void changeTab(int index) => currentIndex.value = index;

  Future<void> apiCall() async {
    await fetchUserBooking();
    getActiveOrderList();
    getCompletedOrderList();
    getCancelledOrderList();
  }

  Future<void> fetchUserBooking() async {
    isBookLoading.value = true;
    try {
      final data = await _bookingService.fetchUserBooking();
      bookedServices.assignAll(data.map((doc) => BookingModel.fromJson(doc.data())));
    } catch (e) {
      final msg = e is FirebaseException ? e.message ?? "Database error" : 'Error fetching user booking data';
      CommonMethods.showErrorSnackBar('Error', msg);
    } finally {
      isBookLoading.value = false;
    }
  }

  void getActiveOrderList() {
    activeServices.assignAll(bookedServices.where((order) => order.serviceStatus == ServiceStatus.active.name));
  }

  void getCompletedOrderList() {
    completedServices.assignAll(bookedServices.where((order) => order.serviceStatus == ServiceStatus.completed.name));
  }

  void getCancelledOrderList() {
    cancelledServices.assignAll(bookedServices.where((order) => order.serviceStatus == ServiceStatus.cancelled.name));
  }

  Future<bool> cancelOrder(BookingModel booking) async {
    isButtonEnabled.value = false;
    try {
      await _bookingService.cancelBooking(booking.orderId);
      return true;
    } catch (e) {
      final msg = e is FirebaseException ? e.message ?? "Database error" : 'Error updating booking status';
      CommonMethods.showErrorSnackBar('Error', msg);
      return false;
    } finally {
      isButtonEnabled.value = true;
    }
  }
}
