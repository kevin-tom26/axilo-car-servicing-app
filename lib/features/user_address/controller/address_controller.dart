import 'package:axilo/common/methods/common_methods.dart';
import 'package:axilo/core/model/car_wash_model.dart';
import 'package:axilo/features/car_selection/model/vehicle_model.dart';
import 'package:axilo/features/slot_booking/model/user_address_model.dart';
import 'package:axilo/features/user_address/service/address_services.dart';
import 'package:axilo/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  final AddressServices _addressService = AddressServices();
  var isAddressLoading = true.obs;
  bool fromProfile = false;

  //
  CarWashModel? carWashService;
  String? bookingDate;
  String? bookingTime;
  Vehicle? selectedVehicle;
  String? serviceType;
  List<Service>? selectedServices;
  String? extraNote;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      fromProfile = args['from_profile'] ?? false;

      carWashService = args['car_wash_service'];
      bookingDate = args['booking_date'];
      bookingTime = args['booking_time'];
      selectedVehicle = args['selected_vehicle'];
      serviceType = args['service_type'];
      selectedServices = args['selected_services'];
      // selectedAddress = args['selected_address'];
      extraNote = args['extra_note'];
    }
    callApis();
  }

  @override
  void onClose() {
    typeController.dispose();
    addressController.dispose();
    super.onClose();
  }

  final typeController = TextEditingController();
  final addressController = TextEditingController();

  //Pick up address screen---------------------------------------------------

  RxList<UserAddressModel> addressList = <UserAddressModel>[].obs;
  Rxn<UserAddressModel> selectedAddress = Rxn<UserAddressModel>();

  Future<void> callApis() async {
    await fetchAllUserAddresses();
  }

  Future<void> fetchAllUserAddresses() async {
    isAddressLoading.value = true;
    try {
      final data = await _addressService.fetchAllUserAddresses();
      addressList.assignAll(data.map((doc) => UserAddressModel.fromJson(doc.data())));
    } catch (e) {
      final msg = e is FirebaseException ? e.message ?? "Database error" : 'Error fetching user Addresses';
      CommonMethods.showErrorSnackBar('Error', msg);
    } finally {
      isAddressLoading.value = false;
    }
    selectedAddress.value = addressList.isNotEmpty ? addressList.first : null;
  }

  Future<bool> addAddress(UserAddressModel address) async {
    CommonMethods.showLoading();
    try {
      await _addressService.addNewAddress(address: address.toJson());
      addressList.insert(0, address);
      selectedAddress.value = address;
      CommonMethods.hideLoading();
      return true;
    } catch (e) {
      final msg = e is FirebaseException ? e.message ?? "Database error" : 'Failed to add User Address';
      CommonMethods.hideLoading();
      CommonMethods.showErrorSnackBar('Error', msg);
      return false;
    }
  }

  void selectAddress(UserAddressModel address) {
    selectedAddress.value = address;
  }

  void goToReviewSummaryScreen() {
    Get.toNamed(AppRoutes.review_summary_screen, arguments: {
      'car_wash_service': carWashService,
      'booking_date': bookingDate,
      'booking_time': bookingTime,
      'selected_vehicle': selectedVehicle,
      'service_type': serviceType,
      'selected_services': selectedServices,
      'selected_address': selectedAddress.value,
      'extra_note': extraNote,
      //  'pickup_delivery_address': selectedAddress
    });
  }
}
