// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:axilo/common/methods/common_methods.dart';
import 'package:axilo/core/local/local_data.dart';
import 'package:axilo/core/model/car_wash_model.dart';
import 'package:axilo/features/main/service/main_service.dart';
import 'package:axilo/utils/constants/image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    callApis();
  }

  final MainService _mainService = MainService();
  RxList<CarWashModel> carServicesList = <CarWashModel>[].obs;

  var currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }

  final List<Map<String, dynamic>> bottomNavItems = [
    {"icon": WImages.home, "label": "Home"},
    {"icon": WImages.explore, "label": "Explore"},
    {"icon": WImages.bookmark, "label": "Bookmark"},
    {"icon": WImages.book, "label": "Booking"},
    {"icon": WImages.help, "label": "Help"},
  ];

  Future<void> callApis() async {
    await _initLocation();
    await getServiceProviderList();
    // await loadUserData();
  }

  Future<void> _initLocation() async {
    final location = await CommonMethods.getCurrentLocation();
    LocalData().isLocationReady.value = location != null;
  }

  Future<void> getServiceProviderList() async {
    try {
      final data = await _mainService.getServiceProviderList();

      carServicesList.assignAll(data.map((doc) => CarWashModel.fromJson(doc.data())));

      if (LocalData().myLocation.value != null) {
        carServicesList.forEach((service) {
          final distance = CommonMethods.getDistance(dest: LatLng(service.latlong.latitude, service.latlong.longitude));
          service.distance = distance != null ? CommonMethods.formatDistanceValue(distance) : '-';
        });
        carServicesList.refresh();
      }
    } catch (e) {
      final msg = e is FirebaseException ? e.message ?? "Database error" : "An unknown error occurred";
      CommonMethods.showErrorSnackBar('Error', msg);
    }
  }

  // Future<void> loadUserData() async {
  //   final user = FirebaseAuth.instance.currentUser!;

  // }
}
